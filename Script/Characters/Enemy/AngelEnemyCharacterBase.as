class AAngelEnemyChracterBase : AAngelCharacterBase
{
    AAngelPlayerCharacterBaseLegacy PlayerRef;
    UPROPERTY(DefaultComponent)
    UAngelEnemyComponent AngelEnemyComponent;
    default AngelEnemyComponent.bHighLighted = false;

    UPROPERTY(BlueprintReadWrite)
    bool CanDealDamage;


    APawn player;
    

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerCollisionDetection;
    default PlayerCollisionDetection.SphereRadius = 800.f;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerAttackCollisionDetection;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    UBoxComponent DamageDetection;

    AAngelEnemyControllerBase AngelEnemyController;



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



    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {

    }


    

    UFUNCTION()
	void OnPlayerDetectedOverlapBegin(UPrimitiveComponent OverlappedComp,AActor OtherActor, UPrimitiveComponent OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        PlayerRef = Cast<AAngelPlayerCharacterBaseLegacy>(OtherActor);
        if(PlayerRef != nullptr)
        {
            AngelEnemyController.PlayerDetected = true;
            Print("PlayerDetected");
		    AngelEnemyController.SeekPlayer();
        }

    }

    UFUNCTION()
	void OnPlayerDetectedOverlapEnd(UPrimitiveComponent OverlappedComp, AActor OtherActor, UPrimitiveComponent OtherComp, int32 OtherBodyIndex)
    {
        PlayerRef = Cast<AAngelPlayerCharacterBaseLegacy>(OtherActor);
        if(PlayerRef != nullptr)
        {
            AngelEnemyController.PlayerDetected = false;
		    AngelEnemyController.StopSeekingPlayer();
            AngelEnemyController.RandomPatrol();
        }

    }

    UFUNCTION()
	void OnPlayerAttackOverlapBegin(UPrimitiveComponent OverlappedComp, AActor OtherActor,  UPrimitiveComponent OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        PlayerRef = Cast<AAngelPlayerCharacterBaseLegacy>(OtherActor);
        if (PlayerRef != nullptr)
        {
            AngelEnemyController.CanAttackPlayer = true;
        }
    }

    UFUNCTION()
	void OnPlayerAttackOverlapEnd(UPrimitiveComponent OverlappedComp, AActor OtherActor,  UPrimitiveComponent OtherComp, int32 OtherBodyIndex)
    {
        PlayerRef = Cast<AAngelPlayerCharacterBaseLegacy>(OtherActor);
        if (PlayerRef != nullptr)
        {
            AngelEnemyController.CanAttackPlayer = false;
            AngelEnemyController.SeekPlayer();
        }
    }

    UFUNCTION()
	void OnDealDamageOverlapBegin(UPrimitiveComponent OverlappedComp, AActor OtherActor,  UPrimitiveComponent OtherComp,int32 OtherBodyIndex, bool bFromSweep, const FHitResult&in SweepResult)
    {
        PlayerRef = Cast<AAngelPlayerCharacterBaseLegacy>(OtherActor);
        if (PlayerRef != nullptr && CanDealDamage)
        {
		// deal damage to player
		Print("Player Damaged");
        }
    }







}