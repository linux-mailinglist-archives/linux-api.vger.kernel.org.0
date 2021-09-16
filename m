Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6120940D90D
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 13:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbhIPLvw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Sep 2021 07:51:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbhIPLvw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Sep 2021 07:51:52 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6c0W-1myYf21vCw-0180WJ; Thu, 16 Sep 2021 13:50:30 +0200
Received: by mail-wr1-f52.google.com with SMTP id w29so9013073wra.8;
        Thu, 16 Sep 2021 04:50:30 -0700 (PDT)
X-Gm-Message-State: AOAM533KezVEBItXayjLHJeBs4c0Ok5S/T4miLZgV/Eu7gfcqNogQ56b
        yr3PiLUA+d38h9TZFX90ye1WBy2j8Mxm0VTTn9w=
X-Google-Smtp-Source: ABdhPJxs3UaUcFX+pAcwIhffLKSdNtMoIzN5geFmZOWwfcg73tPbwN4/tZejRz0vLmSAhJ7TqSb3jNeOPwSCicsLZ78=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr5387217wrv.369.1631793030132;
 Thu, 16 Sep 2021 04:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210913175249.81074-1-andrealmeid@collabora.com>
 <20210913175249.81074-3-andrealmeid@collabora.com> <875yv4ge83.fsf@collabora.com>
 <58536544-e032-1954-ce30-d131869dc95e@collabora.com> <8735q5dutq.fsf@collabora.com>
 <YUMofqnG6zE4BrnR@hirez.programming.kicks-ass.net>
In-Reply-To: <YUMofqnG6zE4BrnR@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Sep 2021 13:50:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Bka5R4dmHE_+xuKTCtMaSZEYvT9jAz7QbgnF_CkeoNQ@mail.gmail.com>
Message-ID: <CAK8P3a3Bka5R4dmHE_+xuKTCtMaSZEYvT9jAz7QbgnF_CkeoNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] futex2: Implement vectorized wait
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Collabora kernel ML <kernel@collabora.com>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vRO+pASNMHgPF6hF40fHX+DqbE9hLgdGBBP80y5PJyrenckIWjO
 sws52cMewARa5Zl8DBGsaUt0W8cabzbMNgPpNmP/G36bqI/GKdL4J+xskVYA78ZG2lJyuVU
 WpCyg40DtSDX3ZuYbs3F/zPQ0vXd/zhMCE7r82Yz55v9BdWRR3qPUHm5tzYpbcY4dRtI/p9
 VyRa6GFh104ahzHQPmSsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:38qiQ78bMSc=:HDlqscvhEwasWyTWmM2fc+
 Z1jnGXskb+NOlnYkKqXFNsmZgLtpQXcK0XdgUhJcm0cxbnQnLe2E3MRzzYuvbpW+1XfXHoqXd
 DCjD5jJk4bSIEm0ZesiTa7Hj3SJwvPFkCVJqXU6bn1tfSjXepmglGt8/wZe5UJZwl6uAjH7nU
 e/y0CxtUhvgLXoz6+xxvMqAIwqnpaB6IXM+JfyXkeESzaN71GuDK8Je71uMs/GMsJlznfsnqS
 DcN+RS1SxUfDcNSgZRrS0x+zsmM17j3RSXDtTLh1Z1h0TNVobwvn+IHDwOZXLhfRjzr/ofu64
 j3Lj8O7xrfxYBSw+PVtGu4bVTxOz0iD7aVBalMuL1jeGBpBZQIP0chjZZhwGWSBLr6LU69n47
 MkbKaQb8HfWhiWgRSjHiUnu41I7ywS/Z/ged6vbX4UJaauAI4ld7OYqbOnxTPVmRhokIiiZbj
 qy6eGAAAwdJwycfHCeSDqbv/HcBa5YNgq22So+MhqBnw1RVvoTICd8usKZQ6MICpufn3s6KS5
 S15Wumd6Qb5zOmD/yTxj/dAEmChx22dqK4bcA1cTVnPKnKRO7kz0tHocOzRauSL3WwZ1KlkuD
 kK9hvOGBgjryrUaC6zb2VrdNO28vH7Zp61+FBNolZFf5VoGJAg6P8V/zDy/5ZkNbhRvBwFDnz
 2hMxczAcjHPA+ycdg3+xKI48N3cHT1EHYUM4KG91appp2/PR0L+NKBSg5VKOrpUCKZf/PUJI7
 3jiR7P38thkf/4tTsa9mEnAptf2ve4BDUcD55g==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 16, 2021 at 1:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 16, 2021 at 12:10:25AM -0400, Gabriel Krisman Bertazi wrote:
>
> > I find this weird.  I'm not even juts talking about compat, but even on
> > native 32-bit. But also, 32 applications on 64, which is a big use
> > case for games.
>
> Seriously, people still make 32bit applications today? And for legacy
> games, I would think the speed increase of modern CPUs would far offset
> this little inefficiency.

There are 32-bit Windows games apparently, because it's easier to build it
that way than having both 32-bit and 64-bit versions.
There may be native 32-bit games built for Linux from the same sources when
that is not written portably, not sure if that's a thing.

One important reason to use compat mode is for cost savings when you can
ship an embedded system with slightly less RAM by running 32-bit user space
on it. We even still see people running 32-bit kernels on Arm boxes that have
entry-level 64-bit chips, though I hope that those will migrate the
kernel to arm64
even when they ship 32-bit user space.

Similar logic applies to cloud instances or containers. Running a 32-bit
Alpine Linux in a container means you can often go to a lower memory
instance on the host compared to a full 64-bit distro.

        Arnd
