class AAngelEnemyChracterBase : AAngelCharacterBase
{
    AAngelEnemyChracterBase PlayerRef;
    UPROPERTY(DefaultComponent)
    UAngelEnemyComponent AngelEnemyComponent;
    default AngelEnemyComponent.bHighLighted = false;

    UPROPERTY(BlueprintReadWrite)
    bool CanDealDamage;

    bool PlayerDetected;
    bool CanAttackPlayer; 
    APawn player;
    

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerCollisionDetection;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerAttackCollisionDetection;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    UBoxComponent DamageDetection;

    AAngelEnemyControllerBase AngelEnemyController;

    UPROPERTY(EditAnywhere)
	float StoppingDistance = 100.0f;

    UPROPERTY(EditAnywhere)
	float AttackRange = 10.0f;

    FTimerHandle SeekPlayerTimerHandle;


    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        AngelEnemyController = Cast<AAngelEnemyControllerBase>(GetController());
        player = Gameplay::GetPlayerPawn(0);


        PlayerCollisionDetection.OnComponentBeginOverlap.AddUFunction(this,n"OnPlayerDetectedOverlapBegin");
        PlayerCollisionDetection.OnComponentEndOverlap.AddUFunction(this,n"OnPlayerDetectedOverlapEnd");
        PlayerAttackCollisionDetection.OnComponentBeginOverlap.AddUFunction(this,n"OnPlayerAttackOverlapBegin");
        PlayerAttackCollisionDetection.OnComponentEndOverlap.AddUFunction(this,n"OnPlayerAttackOverlapEnd");
        DamageDetection.OnComponentBeginOverlap.AddUFunction(this,n"OnDealDamageOverlapBegin");

        AngelEnemyController.ReceiveMoveCompleted.AddUFunction(this,n"OnAIMoveCompleted");


    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {

    }

    UFUNCTION()
    void MoveToPlayer()
    {
        AngelEnemyController.MoveToLocation(player.GetActorLocation(), StoppingDistance, true);
    }

    UFUNCTION()
    void SeekPlayer()
    {
        MoveToPlayer();
        System::SetTimer(this,n"SeekPlayer",0.25f,true);
    }    

    UFUNCTION()
    void StopSeekingPlayer()
    {
        System::ClearTimer(this,"SeekPlayer");
    }
    

    UFUNCTION()
	void OnPlayerDetectedOverlapBegin(UPrimitiveComponent OverlappedComp,AActor OtherActor, UPrimitiveComponent OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        PlayerRef = Cast<AAngelEnemyChracterBase>(OtherActor);
        if(PlayerRef != nullptr)
        {
            PlayerDetected = true;
            Print("PlayerDetected");
		    SeekPlayer();
        }

    }

    UFUNCTION()
	void OnPlayerDetectedOverlapEnd(UPrimitiveComponent OverlappedComp, AActor OtherActor, UPrimitiveComponent OtherComp, int32 OtherBodyIndex)
    {
        PlayerRef = Cast<AAngelEnemyChracterBase>(OtherActor);
        if(PlayerRef != nullptr)
        {
            PlayerDetected = false;
		    StopSeekingPlayer();
            AngelEnemyController.RandomPatrol();
        }

    }

    UFUNCTION()
	void OnPlayerAttackOverlapBegin(UPrimitiveComponent OverlappedComp, AActor OtherActor,  UPrimitiveComponent OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        PlayerRef = Cast<AAngelEnemyChracterBase>(OtherActor);
        if (PlayerRef != nullptr)
        {
            CanAttackPlayer = true;
        }
    }

    UFUNCTION()
	void OnPlayerAttackOverlapEnd(UPrimitiveComponent OverlappedComp, AActor OtherActor,  UPrimitiveComponent OtherComp, int32 OtherBodyIndex)
    {
        PlayerRef = Cast<AAngelEnemyChracterBase>(OtherActor);
        if (PlayerRef != nullptr)
        {
            CanAttackPlayer = false;
            SeekPlayer();
        }
    }

    UFUNCTION()
	void OnDealDamageOverlapBegin(UPrimitiveComponent OverlappedComp, AActor OtherActor,  UPrimitiveComponent OtherComp,int32 OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        PlayerRef = Cast<AAngelEnemyChracterBase>(OtherActor);
        if (PlayerRef != nullptr && CanDealDamage)
        {
		// deal damage to player
		Print("Player Damaged");
        }
    }

    UFUNCTION()
    void OnAIMoveCompleted(FAIRequestID RequestID, EPathFollowingResult Result)
    {
      //   Print("Reach!");
      if(!PlayerDetected)
      {
        AngelEnemyController.RandomPatrol();
      }
      else if (PlayerDetected && CanAttackPlayer)
      {
        StopSeekingPlayer();
        AngelEnemyController.MoveToLocation(player.GetActorLocation(), AttackRange, true);
      }
    }





}