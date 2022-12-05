Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD3642B22
	for <lists+linux-api@lfdr.de>; Mon,  5 Dec 2022 16:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiLEPNR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 5 Dec 2022 10:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiLEPMq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Dec 2022 10:12:46 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FF22AEE
        for <linux-api@vger.kernel.org>; Mon,  5 Dec 2022 07:12:45 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so10761606pgc.2
        for <linux-api@vger.kernel.org>; Mon, 05 Dec 2022 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTaksTMhrvdwxwSo2T6GMW0VI0cIQaqvSTpIlmBV7Ss=;
        b=DZW7ocFy6agYt4w3mjycHQyRGLjyUqSNvP9DMnaRz0hXV//Pvykf2xLuUjuK7yna8E
         Z1xeKYJV8l03gHrD1lutYomcDKG4xS87BYaxn2l1W5JTtAcFzlUA1bmkFQIJu+qivUOh
         qMk7uW5u/9RyoHjCs/XoX29z6Hoc3/OhcX5LZ14A7k1NPbxQRzVARc/jexf2Fsh3ESMT
         KZH1M5Qy/uAf6MH0BEEoegS1ZUeCZmtLWxHBXw3Due6n8lmKwA0ttHy+XB9Re5S2ZxR2
         WFNd3qaKoum8meQOzxM5aKLkcdUei9Jr88enrTyj3EVt6UZ7x2mlr582c2sHmutxacR4
         ImDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTaksTMhrvdwxwSo2T6GMW0VI0cIQaqvSTpIlmBV7Ss=;
        b=yTBL3xHLHsuJBb6cVSpM2PI2bP9Vo9JKvjFoHScCwtiAXB6wB+uaSwIyZ0q5hmBMZq
         nTzluOYk2dCaQAg/oyCglrBxL7hyf+Ub6mJbQI59USz3/fpCDLwn8jjBuueUwOskUM+I
         7t8M/CuZEwGUEfffM+43tCey/L+O9gbE7M6UR8ZP6xgBWlTAG6B/tjJsuaLflCft6ZEV
         v60U8l9croQJEceXFZzgWmqZAPOiVaF2Fu6WKsSqlNXEdhybyktjxXyl5dTkHTRZoNkr
         9XYOfdpKP//G4S/F+Chd1o+NXwfOM+c19BcoHPi6wKBH8Ytg3kYWWMFAIXYmqtIt/Rew
         q6JQ==
X-Gm-Message-State: ANoB5plEMfbYK5SFZfbkDpqbdCyrjV7rMHj259WugvlumuY47t+GQg9k
        EPFr9bViGO1m2oaCgZDMtiwli4UIktUbcl0otDw=
X-Google-Smtp-Source: AA0mqf5l/VqvnoRZIswEW8UnCxGktVhBw0vvFT2+HP6dPdU1HdE0HhhBVZrrffq2I6LPSTwvtZVk54rRN+ZhQVnQbJs=
X-Received: by 2002:a63:4643:0:b0:477:751a:4169 with SMTP id
 v3-20020a634643000000b00477751a4169mr57593865pgk.300.1670253164822; Mon, 05
 Dec 2022 07:12:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:248c:b0:47:300:1003 with HTTP; Mon, 5 Dec 2022
 07:12:44 -0800 (PST)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <atchrimiv@gmail.com>
Date:   Mon, 5 Dec 2022 15:12:44 +0000
Message-ID: <CAO95NvVk_43MrX+PMegxcQdhqBtA_TMTR6F8dWT_vBXdb3rojA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 Please, did you receive my previous message, thanks.
