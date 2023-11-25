class AAngelEnemyControllerBaseBT : AAIController
{
    UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UBehaviorTree BehaviorTree;

    UPROPERTY(DefaultComponent)
    UAIPerceptionComponent PerceptionComp;

    UPROPERTY()
    UAISenseConfig_Sight AISenseConfigSight;
    UAISenseConfig_Hearing AISenseConfigHearing;

    default AISenseConfigSight = AddSightConfig();
    default AISenseConfigHearing = AddHearingConfig();
    default AISenseConfigSight.DetectionByAffiliation.bDetectEnemies = true;
    default PerceptionComp.ConfigureSense(AISenseConfigSight);
    default PerceptionComp.ConfigureSense(AISenseConfigHearing);
    default PerceptionComp.SetDominantSense(UAISenseConfig_Sight::StaticClass());

    
    // default AddSightConfig();


    UPROPERTY(EditDefaultsOnly)
	FName TargetKey = n"SensedPawn";
    UFUNCTION(BlueprintOverride)
    void ConstructionScript()
    {
        
    }

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        RunBehaviorTree(BehaviorTree);
        
    }

    UFUNCTION()
    void OnSeePawn(APawn PlayerPawn)
    {
        AAngelPlayerCharacterBase Player = Cast<AAngelPlayerCharacterBase>(PlayerPawn);
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
            AIHelper::GetBlackboard(this).SetValueAsBool(FName("Can See Player"), SeePlayer);
            AIHelper::GetBlackboard(this).SetValueAsObject(FName("Player Target"), Player);
        }
        else
        {
            AIHelper::GetBlackboard(this).SetValueAsBool(FName("Can See Player"), SeePlayer);
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
    void SetSensedTarget(APawn NewTarget)
    {
        AIHelper::GetBlackboard(this).SetValueAsObject(TargetKey,NewTarget);
    }

    UFUNCTION()
    void OnHearNoise(APawn PawnInstigator, const FVector&in Location, float32 Volume)
    {
        if(PawnInstigator != GetControlledPawn())
        {
            SetSensedTarget(PawnInstigator);
            Print("Noise Heard");
        }
    }


}