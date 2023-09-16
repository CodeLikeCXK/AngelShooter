class AAngelEnemyChracterBase : AAngelCharacterBase
{
    UPROPERTY(DefaultComponent)
    UAngelEnemyComponent AngelEnemyComponent;
    default AngelEnemyComponent.bHighLighted = false;

    UPROPERTY(BlueprintReadWrite)
    bool CanDealDamage;

    bool PlayerDetected;
    bool CanAttackPlayer; 
    

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerCollisionDetection;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerAttackCollisionDetection;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    UBoxComponent DamageDetection;

    AAngelEnemyControllerBase AngelEnemyController;


    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        AngelEnemyController = Cast<AAngelEnemyControllerBase>(GetController());

    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
    }

    UFUNCTION()
    void HighLightActor()
    {
         AngelEnemyComponent.bHighLighted = true;
    }

    UFUNCTION()
    void UnHighLightActor()
    {
         AngelEnemyComponent.bHighLighted = false;
    }






}