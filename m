Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083A4735E1F
	for <lists+linux-api@lfdr.de>; Mon, 19 Jun 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFSUDT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jun 2023 16:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjFSUDR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jun 2023 16:03:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D8CE65
        for <linux-api@vger.kernel.org>; Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b5465a79cdso12802165ad.3
        for <linux-api@vger.kernel.org>; Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687204996; x=1689796996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2vsVFtTkQYhqMmseMllBPLpJkQ52+kcj5AVBSFXuKs=;
        b=JsVpqeSoU9JGqhw/Knvq+EH87u0+brLVuGMPOl8wehYwMXal8PD7rLPtJBQ/LuIXD5
         q3wqzN82EFF2hMFosDRrnb1S1epH4esiYijM7wdbAxvyvzl4rwMrBd7CSb+DzCUf5j3q
         T3LWRqxFv4IL50FXaZc8BOq6WyjU0DNPTavMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204996; x=1689796996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2vsVFtTkQYhqMmseMllBPLpJkQ52+kcj5AVBSFXuKs=;
        b=V24wvMGE3x9Sw7fVBlOpaAIQnWtiFo4Jxvi47w6acyRPQWxTii7lBWS0sb4wAOgPO0
         mZ8DDwgZggcgmufODks5H0PoMb8mVMz7srqKcDK+osquxuSfwEHqMgYQRFfK6Txtt8dt
         l4+Mf80dMbtwwZaU5qD+Z2vmALdAJrJ0EUFevEfnq1+GD5Cne/huPhWD+n6aQzuBjLw6
         05AaUrTfVFukqbrqfLivPXPqL7aSErvrDnPCMdle9aUMzKIfCBwV3ecLKBSam5x56puB
         zbCzXo5yDk8+6QU+ivzLlrH72zbS+xoB6lIQV7Tb4OZYx2+GsM/nJfRoto8TfqCmRyNu
         cahA==
X-Gm-Message-State: AC+VfDzfz43ZdqFeDxEgJX0DBCpBXTWUkMmgLXGfarJQmzz7hlM2JIXv
        wTA0XQ1zTV4qrVllf6qe4PHdtO/ZAFgo3iXZ1rg=
X-Google-Smtp-Source: ACHHUZ5HqjiOiMuPXsXe61fAouVKC1e7CFohAxEHW/IHu7rnhqq6QlH4Id/lSqykOkNqmpqcNWkgTg==
X-Received: by 2002:a17:902:eac2:b0:1b1:ae33:30de with SMTP id p2-20020a170902eac200b001b1ae3330demr8178420pld.13.1687204996405;
        Mon, 19 Jun 2023 13:03:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b001a072aedec7sm221542plg.75.2023.06.19.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:03:15 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:03:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v11 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <202306191303.7F374EC@keescook>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
 <20230616165055.4705-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616165055.4705-12-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 16, 2023 at 09:50:55AM -0700, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
