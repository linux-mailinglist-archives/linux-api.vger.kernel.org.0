Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B96907BE
	for <lists+linux-api@lfdr.de>; Thu,  9 Feb 2023 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBILvT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Feb 2023 06:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBILuo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Feb 2023 06:50:44 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468FF5AB0F
        for <linux-api@vger.kernel.org>; Thu,  9 Feb 2023 03:37:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h4so1721225lja.2
        for <linux-api@vger.kernel.org>; Thu, 09 Feb 2023 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN5dmIKNiTeuwb/3TvmDWzfH1BwGxtn7YPjkX4NxKgo=;
        b=N1a2K6KqYxkNBfNNdZk1zWrrpSnrtKQTdw0K8qC6sbrnuleoaTBhY2+YjebvTfU08k
         fGcKceMiyw8nnekShPLp7eG12Po4zvEdpy5kbGUrIDcuoagKRU3ryR9lOgm8oZcDExSr
         taeWcKcc2KBRiGXGft7vImb88wy18ZRCM6NiF2GPtObRj1kT8Hdvv/tbxmf7cJE5v7WA
         VTp7RBEF282iQqmiDm+TxgQ2Tks2UGGRwl03lM3ArpwZaJaDFkMQBb03blPqZvYoaQxS
         Jx6Wllzmmyo9q06fjyX4wReOZWzYEC0MeiHl/HhyjDtBMhQW6NC0sx46Gl0fFfcXuNqH
         /6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gN5dmIKNiTeuwb/3TvmDWzfH1BwGxtn7YPjkX4NxKgo=;
        b=mE+50ax//QBODQdLb82Jbf6QTwGvv1iqqLZfxsLfV9HYCQvr8lmgZFBFugulfm6hok
         BIaSMJ3TW+XPhoyCb8jBDMtSlRTqGu/c3CyEhrvn+GcYw4gciyUD4HES+YQ1YNReS4kL
         OIKn1qmkis6jNaqOQLTSBpeQm02Ps+a347wHrpt3KE7eJ9gMz9wLROyPnSCeJAvF0MS6
         aKlEZySEZleR+uyUf2NjQcIvtfcSIJBNUmRkEt1X2pffl3c4rHK/GmtzCPl+thOS4ymw
         nVySsmjgxLpFPea3ZDCiM4l/mE1G2120WzXVKbG8bUzbYlUc7dllNsM6HZH3xFHZrgHu
         E8Rw==
X-Gm-Message-State: AO0yUKWKSs77K83xLYN8TtdXfVnH0QIYnoXNewRVuoCTJeKekoiUc0Ci
        Tnuxpx6Kes36ndC01+V/xBfhhoQZDfrVaa9sLGHMtA==
X-Google-Smtp-Source: AK7set+L0OW3rn1staXflxpNU94CdVo17mvAyMohGACHZ3A24K+HoDQCWPu5p031s/Er2aF2ZbvvgkWsXuhdOkQnbv8=
X-Received: by 2002:a2e:8e28:0:b0:28a:a1d3:572f with SMTP id
 r8-20020a2e8e28000000b0028aa1d3572fmr1794667ljk.20.1675942650395; Thu, 09 Feb
 2023 03:37:30 -0800 (PST)
MIME-Version: 1.0
References: <mhng-9e6b4607-6bea-411c-b843-916c1e0798ee@palmerdabbelt-glaptop>
 <182c1d4e-a117-79d6-4dd1-8e3c8a447b4a@ghiti.fr> <CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com>
In-Reply-To: <CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Feb 2023 12:37:17 +0100
Message-ID: <CACT4Y+Y1s2iE3OF8WHwb7F2crRjgnFCWQfoFvs3d-KgHpMLeKg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, macro@orcam.me.uk,
        david.abdurachmanov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 10 Nov 2022 at 22:01, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 21 Jun 2021 at 00:11, Alex Ghiti <alex@ghiti.fr> wrote:
> >
> > Hi Palmer,
> >
> > Le 23/04/2021 =C3=A0 04:57, Palmer Dabbelt a =C3=A9crit :
> > > On Fri, 02 Apr 2021 11:33:30 PDT (-0700), macro@orcam.me.uk wrote:
> > >> On Fri, 2 Apr 2021, David Abdurachmanov wrote:
> > >>
> > >>> > > >  This macro is exported as a part of the user API so it must
> > >>> not depend on
> > >>> > > > Kconfig.  Also changing it (rather than say adding
> > >>> COMMAND_LINE_SIZE_V2 or
> > >>> > > > switching to an entirely new data object that has its dimensi=
on
> > >>> set in a
> > >>> > > > different way) requires careful evaluation as external binari=
es
> > >>> have and
> > >>> > > > will have the value it expands to compiled in, so it's a part
> > >>> of the ABI
> > >>> > > > too.
> > >>> > >
> > >>> > > Thanks, I didn't realize this was part of the user BI.  In that
> > >>> case we
> > >>> > > really can't chage it, so we'll have to sort out some other way
> > >>> do fix
> > >>> > > whatever is going on.
> > >>> > >
> > >>> > > I've dropped this from fixes.
> > >>> >
> > >>> > Does increasing COMMAND_LINE_SIZE break user-space binaries? I wo=
uld
> > >>> > expect it to work the same way as adding new enum values, or addi=
ng
> > >>> > fields at the end of versioned structs, etc.
> > >>> > I would assume the old bootloaders/etc will only support up to th=
e
> > >>> > old, smaller max command line size, while the kernel will support
> > >>> > larger command line size, which is fine.
> > >>> > However, if something copies /proc/cmdline into a fixed-size buff=
er
> > >>> > and expects that to work, that will break... that's quite unfortu=
nate
> > >>> > user-space code... is it what we afraid of?
> > >>> >
> > >>> > Alternatively, could expose the same COMMAND_LINE_SIZE, but inter=
nally
> > >>> > support a larger command line?
> > >>>
> > >>> Looking at kernel commit history I see PowerPC switched from 512 to
> > >>> 2048, and I don't see complaints about the ABI on the mailing list.
> > >>>
> > >>> If COMMAND_LINE_SIZE is used by user space applications and we
> > >>> increase it there shouldn't be problems. I would expect things to
> > >>> work, but just get truncated boot args? That is the application wil=
l
> > >>> continue only to look at the initial 512 chars.
> > >>
> > >>  The macro is in an include/uapi header, so it's exported to the use=
rland
> > >> and a part of the user API.  I don't know what the consequences are =
for
> > >> the RISC-V port specifically, but it has raised my attention, and I =
think
> > >> it has to be investigated.
> > >>
> > >>  Perhaps it's OK to change it after all, but you'd have to go throug=
h
> > >> known/potential users of this macro.  I guess there shouldn't be tha=
t
> > >> many
> > >> of them.
> > >>
> > >>  In any case it cannot depend on Kconfig, because the userland won't=
 have
> > >> access to the configuration, and then presumably wants to handle any=
 and
> > >> all.
> > >
> > > It kind of feels to me like COMMAND_LINE_SIZE shouldn't have been par=
t
> > > of the UABI to begin with.  I sent a patch to remove it from the
> > > asm-generic UABI, let's see if anyone knows of a reason it should be =
UABI:
> > >
> > > https://lore.kernel.org/linux-arch/20210423025545.313965-1-palmer@dab=
belt.com/T/#u
> >
> > Arnd seemed to agree with you about removing COMMAND_LINE_SIZE from the
> > UABI, any progress on your side?
>
> Was this ever merged? Don't see this even in linux-next.

Ping. Still an issue at least for syzbot.
