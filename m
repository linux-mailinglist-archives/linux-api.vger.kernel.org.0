Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8653440F
	for <lists+linux-api@lfdr.de>; Wed, 25 May 2022 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiEYTOo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 May 2022 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344470AbiEYTOF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 May 2022 15:14:05 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B492FE68
        for <linux-api@vger.kernel.org>; Wed, 25 May 2022 12:11:55 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id i25so5378129vkr.8
        for <linux-api@vger.kernel.org>; Wed, 25 May 2022 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=V6ARNQoWDnumhYFhC7JXSp+b//quogTf1HtJPSN9SqreNCYr0pdgt9cGzRbjUSflth
         hKX0IT2tcMhMlVjlILTruFXi1OlEPENgY/I3x0t3K/Y+9VZednNnPFl7bzNfp8u7/P1f
         mfNu6GbBtsFGlwV86tQNgdpw9p40CbRZ++r7m1bvW6J0K07bN//Ox0euOFGWtfkF3/gC
         g2H5ul/HMLJXysPV5x9ST0fGm8ue5386FIo9ZN9f8e2TEYz2WE4WvrplpYNvH1q2I01l
         /Wh5e1qDRwUEInjiLVS6jMiFtEFCoPH6qYQ4ff4y0ozYTMjN9QDDMyOAyAw0mhlQCTAr
         kLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=OaVxJMCWxVFVGmphDRT7b3BwumALkSTS79bXp1xlHrYSNtsWpRoHdUC5TsCu6y5z3H
         so6dBCs1yyhJFREVnuMVkKqn6+wBsMtAhBcoKoR65l8rIP3dk4CRV95UiZwB2WsizF1Y
         nZAjuemchOnH6zyzQ0lCbfboeIl+RLa4YteBitsiTeqbw8Btmmf+FTp5hpPUQHXNo6P8
         3tGluUAm0U/HiSvMNfGYkTzSoEaFwGuIrtijA01/1NtH16/GIIPvuzlY7Qux9P4iE/RU
         k3sqNCxU1zHGPtVfRCGssuDhmSJnBZ+ybZg7rYfVKtKe5FekOnEGSRVUjymWTci/0e++
         lMhQ==
X-Gm-Message-State: AOAM533b3xX77hFg/+ZmFhMqe1hwW49ACx907G1i3vn25oF2FqqUWSlK
        YsjTXNEGkCtrcU560dhhXK04DyhLGZEGScnlRtk=
X-Google-Smtp-Source: ABdhPJyuOVEbRWx0XXf15NI30o1EWNiJCiif/j2MkMj/6QJte3dCUDKKnfwUc+IPGcJ5fA3pGwywjLZySP/GIm6w/e0=
X-Received: by 2002:a1f:738f:0:b0:357:a16f:f802 with SMTP id
 o137-20020a1f738f000000b00357a16ff802mr6962302vkc.40.1653505913858; Wed, 25
 May 2022 12:11:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d484:0:b0:2bc:cae4:6d22 with HTTP; Wed, 25 May 2022
 12:11:53 -0700 (PDT)
From:   Rolf Benra <olfbenra@gmail.com>
Date:   Wed, 25 May 2022 21:11:53 +0200
Message-ID: <CA+z==VtgajxeM5szWU8kohnauPTTy4t6+YNh0a_y-YRvndojQQ@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Rolf Benra

olfbenra@gmail.com







----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Rolf Benra

olfbenra@gmail.com
