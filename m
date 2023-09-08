Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3247797EEE
	for <lists+linux-api@lfdr.de>; Fri,  8 Sep 2023 01:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjIGXF6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Sep 2023 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjIGXF6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Sep 2023 19:05:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292F1BD3
        for <linux-api@vger.kernel.org>; Thu,  7 Sep 2023 16:05:54 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58dce1f42d6so36418687b3.0
        for <linux-api@vger.kernel.org>; Thu, 07 Sep 2023 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694127953; x=1694732753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISjcm/XAVmNIHdzglOwc4PmVKiJwUPJydrTms3Jl6eg=;
        b=V+cYoJjSOo0+cVER+pLtXFHxL4gpwBiZPAnXuIDNDI/D9tadCcGltM7Gpn37mRxZyI
         4tgJfGHWOJ5hQuzTtPIG2QAgldx3iOq2cwgr/kD858ME5b8wOMTyarbrZeD+JATul5F9
         ZdneCGx6zafxCTiMnAmmcB7fm1FtyyNjDUmba/WjvJGAa99EdAtgM9n//ddztrTMMU8I
         UPd9sr9rolSrW0nTovwbtCIgm/9I/oi9RRPsMuup5I5EBDsO+HavzFM5oBUhC+TzbIcq
         xN9XDrcDZf7Y8hULAyflbVWI1WvlIRPP3RbcggXeIXZKcAYUN8CnbE8/yE4gNibIIEk9
         y93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127953; x=1694732753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISjcm/XAVmNIHdzglOwc4PmVKiJwUPJydrTms3Jl6eg=;
        b=mtM615w4gCUuUOssrL+YhnEdPM5g9PT54ih8OaqR8/pNDNPXN3kZMG3l8P7uJ2nScx
         BgDPqy6P3mKK+kCSaWYOHaHjVi9ikNc8VfJXbUqN1hzm9d4ae+M/pCUHFgwjQfnFhDnx
         fc38mYAC+hEERaKlQeDAh3asaOBNIBCUMl3chfM+Ih3BHdovfPRnCiVwlJ+cOJrNetq9
         ol1b118YQtSpBfGCYM+80k5WowfsP8Ibc+ZbnUpXoXpCxuJY87vy4EeVHSTfvHK+6t7n
         /PYp0y44snSCe1ubsxpSiMpjqG7k0WvG5whA3IxgxPYPw0+mX3/0ZeBbxDQ3fsHw2SfO
         pCPg==
X-Gm-Message-State: AOJu0Yxxvc4IsGMxi1Wcb675r4aLZCQay3GTMLegYM6ygyGGaiESgzoO
        RWMvUs7uDtXvzUrGmXPRPPR2eR1CIyptzisVps1A
X-Google-Smtp-Source: AGHT+IG0HEX4ZGpo0hD4MHng6c+DEbD0YlWxaMovTIzbA3/W8ZnDLQi0HsEjlGcfgzt/69nt84jTXPqcVJSfyieNFCU=
X-Received: by 2002:a81:450f:0:b0:59b:50ed:82e5 with SMTP id
 s15-20020a81450f000000b0059b50ed82e5mr2377444ywa.22.1694127953340; Thu, 07
 Sep 2023 16:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230828195802.135055-5-casey@schaufler-ca.com>
 <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com> <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
 <CAHC9VhT-GVq1D-AKMv_R3uKNm_iDV8uA3pB1ky5ScBnEdoPuvg@mail.gmail.com> <159ad121-e7e7-7d5a-c208-983c7a2b8d6e@schaufler-ca.com>
In-Reply-To: <159ad121-e7e7-7d5a-c208-983c7a2b8d6e@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Sep 2023 19:05:42 -0400
Message-ID: <CAHC9VhQpQUPeL3G7F-QjYZdSvzZUsdd2uc9DYddgWvbQKUitjA@mail.gmail.com>
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 7, 2023 at 6:15=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 9/7/2023 8:42 AM, Paul Moore wrote:
> > ...
> >> Yes. I have a fix ready. There are a couple other touch-ups, too.
> > Great.  Since you are doing another revision, can you double check all
> > of the patch subject lines to ensure you don't have any double spaces?
> >  I see at least one, possibly two more.
>
> Where do you see that? I'm not finding it.

It's possible it may be part of the tooling I'm using.  I checked that
this morning against the raw archives in lore and thought I still saw
at least one patch with that issue, but now that I go back I'm not
seeing it.  My apologies for the confusion.

Regardless, I have updated my scripts so if it is on my end it
shouldn't happen again.

--=20
paul-moore.com
