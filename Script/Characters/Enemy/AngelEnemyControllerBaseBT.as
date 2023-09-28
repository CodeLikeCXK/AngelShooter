class AAngelEnemyControllerBaseBT : AAIController
{
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UBehaviorTree BehaviorTree;

    UPROPERTY(DefaultComponent,EditAnywhere)
    UPawnSensingComponent PawnSensingComp;

    UPROPERTY(DefaultComponent,EditAnywhere)
    UAIPerceptionComponent PerceptionComp;
    

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        RunBehaviorTree(BehaviorTree);
        PawnSensingComp.OnSeePawn.AddUFunction(this,n"OnSeePawn");
        PawnSensingComp.OnHearNoise.AddUFunction(this,n"OnHearNoise");

        
    }

    UFUNCTION()
    void OnSeePawn(APawn PlayerPawn)
    {
        AAngelPlayerCharacterBaseLegacy Player = Cast<AAngelPlayerCharacterBaseLegacy>(PlayerPawn);
        if(Player != nullptr)
        {
            SetCanSeePawn(true, Player);
            RunRetriggerableTimer();
        }
    }

    UFUNCTION()
    void SetCanSeePawn(bool SeePlayer, UObject Player)
    {
        if(SeePlayer)
        {
            AIBlueprintHelper::GetBlackboard(this).SetValueAsBool(FName("Can See Player"), SeePlayer);
            AIBlueprintHelper::GetBlackboard(this).SetValueAsObject(FName("Player Target"), Player);
        }
        else
        {
            AIBlueprintHelper::GetBlackboard(this).SetValueAsBool(FName("Can See Player"), SeePlayer);
            ACharacter EnemyChar = Cast<ACharacter>(GetControlledPawn());
        }
    }

    FTimerHandle RetriggerableTimerHandle;
    
    UFUNCTION()
    void RunRetriggerableTimer()
    {
        System::ClearTimer(this,"RunRetriggerableTimer");

    }

    UFUNCTION()
    void OnHearNoise(APawn Player, FVector&in Location, float32 Volume)
    {

    }
}