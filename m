Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE8744219
	for <lists+linux-api@lfdr.de>; Fri, 30 Jun 2023 20:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjF3SX5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jun 2023 14:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjF3SX5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Jun 2023 14:23:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0BF5
        for <linux-api@vger.kernel.org>; Fri, 30 Jun 2023 11:23:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-be3e2d172cbso2017754276.3
        for <linux-api@vger.kernel.org>; Fri, 30 Jun 2023 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688149434; x=1690741434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpanYO+njUHDnpXmj2VuqKr1DpWx0gxhRp5S2Jn8NmM=;
        b=O+mM9iYTY5FKs8ty8E+sASu8k6bFdDWGMJHfwiKHmu0XBGq1S+MkrDfB9Ogr2GrOqF
         E+ZECtHrX7btdzdRBWAoZ83uKFfUmCF5fE6nQF2PA0rsxHGtYF/OQThgFAumiRsoEwCr
         hAU0X2gyVrX28M0OtQDZuUC9P1BAz+aI4S4z/WzS7ac9R3XZQwUViOjsu7ezwK2IfEKU
         QFOYAiaDIUJ3Q7h2+ctCY9zA2hJFQ1NvvFIuuizCR3XnVALA88xtgPL/cFNunhUJDkuN
         Jp0ZT6EvPN+EmooNbZc3VXjRhqP3CWSh76vSXQrbHRC7CKJsOkURKI56iAGHEh6m73tp
         ddAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149434; x=1690741434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpanYO+njUHDnpXmj2VuqKr1DpWx0gxhRp5S2Jn8NmM=;
        b=AmqhImkSkheBNe8gW7y5J05lfb7ExADJNHr1FaTdrUc6B8NM0nftcnd1jUb0iFs6ga
         MRptHOhWcHq6mDZVLwEkiztvtOwpyzH6uK1IZFLnCwSedJ2gC3rfIQfFsJ2cNJueUA9U
         iqlB5t3h6KMkL29EeE9WSYme6HeAtwWM1B2A0XJEYhbTr1W4jSX2r7GZ3gZmVMfwGmSm
         IBIIHaMaTlDf/qOWisaGnkiHmyZCu3dWa5KlktyYwYu0FgtIKMFRrnZSkGG+xbcmEpWe
         bM+Rs0HK0c41Fo/YIq7ceokYducWauzaBFaY/LCnIzUKEh02eK7ps96plPsHXN/WuEZ3
         ZNyQ==
X-Gm-Message-State: ABy/qLbniKPFxBk4EtXP3dfFrQDXum+bpSEXfvswmvFVsvU+V4t7/Yer
        QheFVrtyM4nIXZeekk3AEzLcOp0zqgcu0rKvmCBn
X-Google-Smtp-Source: APBJJlHriM4wXYGIicfU1/V8qW8Igc6J5g+IrjjFXMz+3W+pM6cR4V+YNeKnEJMXiZpRrz7n3VIi6SeL9EmnJvZB7eE=
X-Received: by 2002:a25:6906:0:b0:ba8:2009:ccbb with SMTP id
 e6-20020a256906000000b00ba82009ccbbmr3731761ybc.46.1688149434576; Fri, 30 Jun
 2023 11:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230629195535.2590-8-casey@schaufler-ca.com> <b09a9753d31dc4b842cc2e058ae01f34.paul@paul-moore.com>
 <d39d5784-058f-9298-1cdb-2f0e550b206a@schaufler-ca.com>
In-Reply-To: <d39d5784-058f-9298-1cdb-2f0e550b206a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Jun 2023 14:23:43 -0400
Message-ID: <CAHC9VhQfejt=5+pUbUGZr1XAAEQsdmGBsenTiP-na6wmUUVUVg@mail.gmail.com>
Subject: Re: [PATCH v12 7/11] LSM: Helpers for attribute names and filling lsm_ctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 30, 2023 at 1:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 6/29/2023 7:14 PM, Paul Moore wrote:
> > On Jun 29, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Add lsm_name_to_attr(), which translates a text string to a
> >> LSM_ATTR value if one is available.
> >>
> >> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> >> the trailing attribute value.
> >>
> >> All are used in module specific components of LSM system calls.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >> ---
> >>  include/linux/security.h | 14 +++++++++++++
> >>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
> >>  security/security.c      | 44 +++++++++++++++++++++++++++++++++++++++=
+
> >>  3 files changed, 82 insertions(+)
> > ..
> >
> >> diff --git a/security/security.c b/security/security.c
> >> index 199db23581f1..72ad7197b2c9 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -770,6 +770,50 @@ static int lsm_superblock_alloc(struct super_bloc=
k *sb)
> >>      return 0;
> >>  }
> >>
> >> +/**
> >> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> >> + * @ctx: an LSM context to be filled
> >> + * @context: the new context value
> >> + * @context_size: the size of the new context value
> >> + * @id: LSM id
> >> + * @flags: LSM defined flags
> >> + *
> >> + * Fill all of the fields in a user space lsm_ctx structure.
> >> + * Caller is assumed to have verified that @ctx has enough space
> >> + * for @context.
> >> + *
> >> + * The total length is padded to a multiple of 64 bits to
> >> + * accomodate possible alignment issues.
> > We should drop the sentence above now that alignment is the caller's
> > responsibility, but since that was largely my fault I can fix this up
> > during the merge assuming you're okay with that Casey.
>
> I have to fix the error in patch 8/11 anyway. I can fix this, too.

Great, thanks.

--=20
paul-moore.com
