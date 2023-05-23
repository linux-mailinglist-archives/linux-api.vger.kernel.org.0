Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA470E72C
	for <lists+linux-api@lfdr.de>; Tue, 23 May 2023 23:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjEWVNG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 May 2023 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjEWVNF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 May 2023 17:13:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BCBDD
        for <linux-api@vger.kernel.org>; Tue, 23 May 2023 14:13:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so290874276.3
        for <linux-api@vger.kernel.org>; Tue, 23 May 2023 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684876383; x=1687468383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe/mryGe1SPximyn0Y5PuCcjJFRj4T+DAjqI4VqhjcA=;
        b=HWAIhiLYx7ppesW7Fo1Uvikjm6LjImfoNRrvTZs1B6bqi4KYaPovtkfGi22fBD3xK4
         rLH4Iby1fDBFyJwh6aEGMc6MLnTkTpccwcXeWLBsFs/LlZ5XzgX+Efhpk+No+y8QruKd
         KmoAcnrTpdXYoW7P+g51kp3v4BLPkhdYhztyuGC5MBS7D9290MEPRLHFCkAFnkmxx5IL
         8bSu20mEqukQTfjGVka6UyEBm5daBXZSxClBamEjJFKc9R8GoQ/4JfxXtSDJ9dmrhhuj
         GkrYa4kUutzZymKIo+0jsSTedUTwPQX3YI9cWsN4dn37W3yUJRkDoOX0UBfNzcKeZ0a7
         dZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684876383; x=1687468383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe/mryGe1SPximyn0Y5PuCcjJFRj4T+DAjqI4VqhjcA=;
        b=GIizx2xl58sYBfQp0kqt/6XBuxTUXNF2yU0QXXROWj85h22mVTTxizREN9WMZMPQRr
         VwDmnlC5V/nWGCxQDUO7c41BDkdASlv+SA3DZJ6h+8043puxTLTnMzNbo8pe9oAPyB4i
         v6WI/EPPwLIYbfn2a6hZQfGKsCNwYIQP8AyPb2Exf+0PO458uGnciEiK+gSgjvYFhi1V
         m9yDZA/3vpmZaDqaRSbwRgi7EcAu0yQ2n9blQaktl+5XWMrxj8P4edGWHOK9r4EJRomE
         J+Kc62os88NfYNslXsyt3v4Jj9PN82iXJDXG3L1WhdYjVmJTCgHZ4NorBBtbRgJ+nXC0
         fsNw==
X-Gm-Message-State: AC+VfDxfqTtOx5EmzDj95LNYlRWzUszUi3h0pL+sJ1/j6bAY4DHdnCbz
        afzLwd77Sx4GKqFzMTWblnG/jJEs0e0x7QzoBCj3
X-Google-Smtp-Source: ACHHUZ4f+Ek2wXY3RmRVYqhQsfzKxKiVZYioKxz8k/qtxoy0rfb2ON2OI16pGO/EygZcjpN5BkNdfM4XzhbhBXF8YV0=
X-Received: by 2002:a25:74c6:0:b0:ba8:24ff:f7dd with SMTP id
 p189-20020a2574c6000000b00ba824fff7ddmr16009648ybc.48.1684876383388; Tue, 23
 May 2023 14:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com> <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
In-Reply-To: <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 17:12:52 -0400
Message-ID: <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
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

On Tue, May 23, 2023 at 2:13=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote=
:
> On Mon, May 22, 2023 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, May 18, 2023 at 5:26=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> > > On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> > > > Adds a new getprocattr hook function to the Landlock LSM, which tra=
cks
> > > > the landlocked state of the process. This is invoked when user-spac=
e
> > > > reads /proc/[pid]/attr/domain
> > >
> > > Please don't add a Landlock specific entry directly in the attr/
> > > directory. Add it only to attr/landlock.
> > >
> > > Also be aware that the LSM maintainer (Paul Moore) wants to move
> > > away from the /proc/.../attr interfaces in favor of a new system call=
,
> > > which is in review.
> >
> > What Casey said above.
> >
> > There is still some uncertainty around timing, and if we're perfectly
> > honest, acceptance of the new syscalls at the Linus level, but yes, I
> > would very much like to see the LSM infrastructure move away from
> > procfs and towards a syscall API.  Part of the reasoning is that the
> > current procfs API is ill-suited to handle the multiple, stacked LSMs
> > and the other part being the complexity of procfs in a namespaced
> > system.  If the syscall API is ultimately rejected, we will need to
> > revisit the idea of a procfs API, but even then I think we'll need to
> > make some changes to the current approach.
> >
> > As I believe we are in the latter stages of review for the syscall
> > API, perhaps you could take a look and ensure that the current
> > proposed API works for what you are envisioning with Landlock?
> >
> Which review/patch to look for the proposed API ?

See Casey's reply if you haven't already.  You can also find the LSM
list archived on lore.kernel.org; that is probably the best way to
track LSM development if you don't want to subscribe to the list.

* https://lore.kernel.org/linux-security-module

> I guess ChromeOS will need to backport to 5.10 when the proposal is accep=
ted.

Maybe?  Distro specific backports aren't generally on-topic for the
upstream Linux mailing lists, especially large commercial distros with
plenty of developers to take care of things like that.

--=20
paul-moore.com
