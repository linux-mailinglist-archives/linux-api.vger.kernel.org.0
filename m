Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39054B21A
	for <lists+linux-api@lfdr.de>; Tue, 14 Jun 2022 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiFNNPo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jun 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiFNNPn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jun 2022 09:15:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101A36B5F
        for <linux-api@vger.kernel.org>; Tue, 14 Jun 2022 06:15:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso6213399wms.2
        for <linux-api@vger.kernel.org>; Tue, 14 Jun 2022 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SzYFHVgWm0kd+ASxjFHC1PCrJjtBcqT81Pevzo2pEAE=;
        b=Ga6bnhBErS4nTSO0/ofz7v4Quyidt5EBEMlHYykXUrFOzJRu3VTNBgp8TNHAu01yWy
         eXsYD5FGhEaPEA2MkJiPxUCTlBzEUvcvDax0yz89Ue8eLvH3I8CNWgZtj8lxHgd8cSJT
         o4i4u6TKMY4JCuiuTmYflku22FVjqmzl7NXzgGN9NrCdXXIHjMj0Yp5/mOVHeCneUDC0
         8R3377NqPV5u2fc4oGtCkyBuNum26FF8WzUjbcjQaFrPS10aqrZ2NBC77kTnudygp1Su
         gS3yE9vuBgls3i7gDYxVRw8GxEZLBgGgijhZ4exlqZlvG01BuXsnov8gGBLLoH4bvJCH
         BNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SzYFHVgWm0kd+ASxjFHC1PCrJjtBcqT81Pevzo2pEAE=;
        b=PofCfUyyUYZTbxhfR95wQgUqqdL+CtsVvWnKgxwbhJ/g4k10x/cB1J/P2FhPuy+CK1
         uDGsdV7RxHg4xnupBKUlDx7zLevgDcutrUTTzrgib5aZL+RRggrl9oi7RHre1ZHjnfmg
         H7K8jMt1GarWCm6d5s03+eK/816Vcdeg+JjdlStryWnwFTtzqMUoWf9RGamAHt9ubX3l
         hhj8K5OvX9dA+UiWQYOs7xYWPuVh3gfZ78MmwAuwhViH/nCzwXCDTfKfsHC/cMXX8tx3
         bGiOhKwv8slmH1mhygE23q+3/zMgjYHHJlhpRhMGrkXL++lh+MF4lK5/7KMERIwmmiBq
         v+pQ==
X-Gm-Message-State: AOAM530ydpakTCRltBNPJjq47Rp9IbW+wCLmVRr28H7mqRQohYvMSIaq
        IZXndOEAXDXiDOZfWPtqSQZTNp2V/HOrrtOzAs6kbm6f+ds=
X-Google-Smtp-Source: ABdhPJxY/C8NFhW4fNU8nYvu8RzBSDt2EoWQiXb42R3DbsKC9Yg3AHKfBBTx3P+H+TQ9ucB9QZpWApvdmR5fxpzGcTY=
X-Received: by 2002:a7b:c752:0:b0:39c:4853:24f8 with SMTP id
 w18-20020a7bc752000000b0039c485324f8mr4029841wmk.184.1655212540620; Tue, 14
 Jun 2022 06:15:40 -0700 (PDT)
MIME-Version: 1.0
From:   Federico Di Pierro <nierro92@gmail.com>
Date:   Tue, 14 Jun 2022 15:15:29 +0200
Message-ID: <CAMZm_C=o-rc4a+u_8-pFJtmL_2drwczASMRTqszamrks5Zm_OA@mail.gmail.com>
Subject: pgprot_encrypted macro is broken
To:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi everyone,

In our kmod we use the `pgprot_encrypted` macro.
It seems like the macro cannot be used on 5.18+ kernels because commit
b577f542f93cbba57f8d6185ef1fb13a41ddf162 broke it.

Basically, the macro definition was:
`__pgprot(__sme_set(pgprot_val(prot)))`

but after the commit, it was changed to:
`__pgprot(cc_mkenc(pgprot_val(prot)))`.

But `cc_mkenc` symbol is not exported!

This leads to build issues:
> ERROR: modpost: "cc_mkenc" undefined!

Is this a bug?
Is there any workaround?

Thank you,
Regards
Federico
