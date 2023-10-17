Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDCE7CC83C
	for <lists+linux-api@lfdr.de>; Tue, 17 Oct 2023 17:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjJQP6k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Oct 2023 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjJQP6j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Oct 2023 11:58:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264EF9E
        for <linux-api@vger.kernel.org>; Tue, 17 Oct 2023 08:58:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7fb84f6ceso71164887b3.1
        for <linux-api@vger.kernel.org>; Tue, 17 Oct 2023 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697558317; x=1698163117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+Ae4qQ6cbR4vS2vgj340YtDADSFX7qvlsF9biuQBy8=;
        b=GiWfB/pV2HgEVii073zNJxv/CUUwDOo6lLMqyMNPMmUBQ2Kpzm6PghlkZOHKVlYDNt
         epkpE2h+K+yTEpI4qzL/SklOhCg0gNKwsBxsvvKwjhnUPqFDxkP4/jjEss/Z7dgKOIdj
         YvhRu8CDUV4RfrD5NvfdW8vR0h3QUbw8kOjfhYPaazQnPSIeOuVvTwWWPiPPz0h2/bVk
         dXheED5UictAZE+Aiep+0gfVYq/anLUo4PkDUe1T2yDbVUaqUQ6IycWfSbN+qap7ktgx
         Qoguz+ubgjOCQNlPlbiAi4wiZP+wZ0TuQgdRRBHMVWfM++7aVUMIXMmY1xTTo91Eq/e7
         K2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558317; x=1698163117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+Ae4qQ6cbR4vS2vgj340YtDADSFX7qvlsF9biuQBy8=;
        b=lk7z7e/QxeCFu0F1AbEq11+lmloHoj9pihsAIWocPa5tf9Gzv2SmW1xPK/lCaBwo4m
         5UgPcM4puQ2oiBb4dg8SW3hCKBWudG7vfAFXK474DcMH6jegw+xuIA+If951PcknhapS
         4xaHrbEPfbptc374OragMXOW+RJpedA/0b/qLW3IpLGq/KT/lXLBn6Q/j3AvojeuhQlW
         q9fa+qE9h3dMNUZ8PGrEQnROulIqqDIqz6spcJVK2w4CaYNi5cEvCGI6T4oAa63N9uPO
         DJz/raIV3VpoC5HXQg3QsCVorUMhPoyL6Y+M+TU7z2oWCb+wljVPSkqCdaX+eYD8Bhcd
         93Ig==
X-Gm-Message-State: AOJu0YzViSZyYX46yFUM9i1lmaw1rvU2Vz5ZOl58LaEvnfrg0+KbAfHk
        UCdKgqSfjMQhUUx/1LDD6/tXo9dSNJTXHUao5s7N
X-Google-Smtp-Source: AGHT+IGM4BlgRfbjn+CtsOBO83xa+URxvbeHOZd6mSxM1RpaUmTl5SM9OV3vfSjG8sLk3M7oJigKD6ODUTVOzpBsuQg=
X-Received: by 2002:a25:254:0:b0:d9b:6264:b79e with SMTP id
 81-20020a250254000000b00d9b6264b79emr2308973ybc.53.1697558316522; Tue, 17 Oct
 2023 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
 <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
 <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
 <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com> <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
In-Reply-To: <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Oct 2023 11:58:25 -0400
Message-ID: <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
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

On Tue, Oct 17, 2023 at 3:01=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2023-10-16 at 11:06 -0400, Paul Moore wrote:
> > On Mon, Oct 16, 2023 at 8:05=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, =
I
> > > think it should be LSM_ID_INTEGRITY.
> > >
> > > Mimi, all, do you agree? If yes, I send a patch shortly.
> >
> > I believe LSM_ID_IMA is the better option, despite "integrity" already
> > being present in Kconfig and possibly other areas.  "IMA" is a
> > specific thing/LSM whereas "integrity" is a property, principle, or
> > quality.  Especially as we move forward with promoting IMA as a full
> > and proper LSM, we should work towards referring to it as "IMA" and
> > not "integrity".
> >
> > If anything we should be working to support "IMA" in places where we
> > currently have "integrity" so that we can eventually deprecate
> > "integrity".
>
> Hi Paul
>
> I fully understand your argument. However, 'integrity' has been the
> word to identify the integrity subsystem since long time ago.
>
> Reducing the scope to 'ima' would create some confusion since, while
> 'ima' is associated to integrity, it would not encompass EVM.

Using LSM_ID_IMA to reference the combination of IMA+EVM makes much
more sense to me than using LSM_ID_INTEGRITY, especially as we move
towards promoting IMA+EVM and adopting LSM hooks for integrity
verification, opening the door for other integrity focused LSMs.

--=20
paul-moore.com
