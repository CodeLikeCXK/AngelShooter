class AAngelPlayerControllerLegacy : APlayerController
{
  IEnemyInterface LastActor;
  IEnemyInterface ThisActor;

  UInputComponent InputComponent;



  UFUNCTION(BlueprintOverride)
  void BeginPlay()
  {
    InputComponent = UInputComponent::Get(this);
    PushInputComponent(InputComponent);
      //setup input   
     bShowMouseCursor = true;
     EMouseCursor DefaultMouseCursor = EMouseCursor::Default;  
  }

  UFUNCTION(BlueprintOverride)
  void Tick(float DeltaTime)
  {     
     CursorTrace();
  }

  UFUNCTION()
  void CursorTrace()
  {
      FHitResult CursorHit;
      GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, CursorHit);
      if(CursorHit.bBlockingHit) return;

      LastActor = ThisActor;
      ThisActor = Cast<IEnemyInterface>(CursorHit.GetActor());


      //line trance from cursor

      if(LastActor == nullptr)
      {
        if (ThisActor != nullptr)
        {
          ThisActor.HighLightActor();
        }
        else
        {
          
        }
      }
      else
      {
        if(ThisActor == nullptr)
        {
          LastActor.UnHighLightActor();
        }
        else
        {
          if(LastActor != ThisActor)
          {
            LastActor.UnHighLightActor();
            ThisActor.HighLightActor();
          }
          else
          {
            
          }
        }
      }


  }
}
