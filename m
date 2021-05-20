Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00238B8EC
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhETVYe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:24:34 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:44580 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhETVYd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:24:33 -0400
Received: by mail-ej1-f50.google.com with SMTP id lz27so27444302ejb.11;
        Thu, 20 May 2021 14:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QZCjGGQzo62kjW+htbxsvDcnxh1XkGFFLyzifku0P8=;
        b=m9x16Z5pRS6D1i2o+NpeJ/6q0Re49pzFKZSCL/W49eHiu8DBgyUCnWbjUqT4Tb/jq9
         vKnTEAEHJM8VgwGSRXZnHuw9CgUTaNqrLP/8SGCkEpSf57HqYQMJmkn4j1ihv2jAF6Ex
         tNdNDyjPy03F841Hr/Nxz67Wy2wZD59AAFgQGa1KCVm+wX0Vg0XlaA73qOAChs07XOXU
         64wa5a0Z3O85VfUC3SUqkH4KGElPEjZ9PmkteCMQAOSdv/rtoi/hUwV9K/wqN5RF5YHP
         Z8huClyqpqlBsmZU32IlqvfvNP3zm+fOSax/6SM89xHp/oj7WiauUvJzW5qxeWSZvHnR
         rcFQ==
X-Gm-Message-State: AOAM531oKFpTTMNhs5CcxytE9kYqMH34+LT0g5+4FeFFqHjnBgNhQH3Q
        c6LvcnNoXLx8SbGrXvE1NY3srYDVhPyCWDdU6rc=
X-Google-Smtp-Source: ABdhPJxTYpFsr6+PpLb8DlYBOxH+GMFJU1dlizi414eWaC07eXoiSXEJYZ5LuZscjGALK/3kDYFRGqthncH+EjXUGyA=
X-Received: by 2002:a17:906:2dca:: with SMTP id h10mr6480711eji.507.1621545789994;
 Thu, 20 May 2021 14:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87k0ntazyn.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 20 May 2021 17:22:58 -0400
Message-ID: <CAJvTdK=DCdwc86VdCVsCH+et6aGuAE3hi-wKmE5769SA0g1H-Q@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 4:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:

Thomas,

> > AMX is analogous to the multiplier used by AVX-512.
> > The architectural state must exist on every CPU, including HT siblings.
> > Today, the HT siblings share the same execution unit,
> > and I have no reason to expect that will change.
>
> I'm well aware that HT siblings share the same execution unit for
> AVX.
>
> Though AMX is if I remember the discussions two years ago correctly
> shared by more than the HT siblings which makes things worse.

I regret that we were unable to get together in the last year to have
an updated discussion.  I think if we had, then we would have saved
a lot of mis-understanding and a lot of email!

So let me emphasize here:

There is one TMUL execution unit per core.
It is shared by the HT siblings within that core.

So the comparison to the AVX-512 multiplier is a good one.

Len Brown, Intel Open Source Technology Center
