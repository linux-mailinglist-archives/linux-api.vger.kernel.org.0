Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354B41889D1
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2020 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgCQQJw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Mar 2020 12:09:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58740 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQJw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Mar 2020 12:09:52 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEEmm-0004fx-QV; Tue, 17 Mar 2020 16:09:44 +0000
Date:   Tue, 17 Mar 2020 17:09:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200317160943.2qquqsa4l3oc7ii2@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAKgNAkh7=2Noyn0o3880xbbi4w5oiwqs9ibTYLtheqzxne3mbQ@mail.gmail.com>
 <20200317142350.ssraami3a4vnk5po@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317142350.ssraami3a4vnk5po@yavin>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 18, 2020 at 01:23:50AM +1100, Aleksa Sarai wrote:
> On 2020-03-17, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> > [CC += linux-api; please CC on future versions]
> > 
> > On Tue, 17 Mar 2020 at 09:32, Adrian Reber <areber@redhat.com> wrote:
> > > Requiring nanoseconds as well as seconds for two clocks during clone3()
> > > means that it would require 4 additional members to 'struct clone_args':
> > >
> > >         __aligned_u64 tls;
> > >         __aligned_u64 set_tid;
> > >         __aligned_u64 set_tid_size;
> > > +       __aligned_u64 boottime_offset_seconds;
> > > +       __aligned_u64 boottime_offset_nanoseconds;
> > > +       __aligned_u64 monotonic_offset_seconds;
> > > +       __aligned_u64 monotonic_offset_nanoseconds;
> > >  };
> > >
> > > To avoid four additional members to 'struct clone_args' this patchset
> > > uses another approach:
> > >
> > >         __aligned_u64 tls;
> > >         __aligned_u64 set_tid;
> > >         __aligned_u64 set_tid_size;
> > > +       __aligned_u64 timens_offset;
> > > +       __aligned_u64 timens_offset_size;
> > >  };
> > >
> > > timens_offset is a pointer to an array just as previously done with
> > > set_tid and timens_offset_size is the size of the array.
> > >
> > > The timens_offset array is expected to contain a struct like this:
> > >
> > > struct set_timens_offset {
> > >        int clockid;
> > >        struct timespec val;
> > > };
> > >
> > > This way it is possible to pass the information of multiple clocks with
> > > seconds and nanonseconds to clone3().
> > >
> > > To me this seems the better approach, but I am not totally convinced
> > > that it is the right thing. If there are other ideas how to pass two
> > > clock offsets with seconds and nanonseconds to clone3() I would be happy
> > > to hear other ideas.
> 
> While I agree this does make the API cleaner, I am a little worried that
> it risks killing some of the ideas we discussed for seccomp deep
> inspection. In particular, having a pointer to variable-sized data
> inside the struct means that now the cBPF program can't just be given a
> copy of the struct data from userspace to check.

I suggested two alternative approaches in a response to this. The
easiest one would be to simple assume that the struct doesn't change
size.
(But haven't we crossed that bridge with the set_tid array already?)
