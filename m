Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA518AE20
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 09:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgCSIL5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 04:11:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43906 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgCSIL4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 04:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584605514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1NFGmp/ZfO2b8+xQcK8SU35k88uC0jA2Heq1vKlCdU=;
        b=Ow1azw8UG+duFMw9atLpskBwUBODVOVm6TnpgYITR2YA9FLhAGPk9bXaUgbhxz5novhje6
        7MEGCQV5HHZA7pvNcvk0u8Tey6SY1XKADhJ0jBchlmSc9+VHWzliuKGKD5pi5lNhf8OzPo
        I7mUnxJPLlo2DxkxyKCYWBEzkNH7WN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-8_ZP5jXTN323QX24HDHZtQ-1; Thu, 19 Mar 2020 04:11:48 -0400
X-MC-Unique: 8_ZP5jXTN323QX24HDHZtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FAE13EA;
        Thu, 19 Mar 2020 08:11:46 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-179.ams2.redhat.com [10.36.112.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE1776EFA8;
        Thu, 19 Mar 2020 08:11:39 +0000 (UTC)
Date:   Thu, 19 Mar 2020 09:11:37 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: clone3: allow creation of time namespace with offset
Message-ID: <20200319081137.GC223854@dcbz.redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
 <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
X-Operating-System: Linux (5.5.8-200.fc31.x86_64)
X-Load-Average: 1.26 0.61 0.49
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 18, 2020 at 11:18:53AM +0100, Arnd Bergmann wrote:
> On Tue, Mar 17, 2020 at 9:32 AM Adrian Reber <areber@redhat.com> wrote:
> >
> > This is an attempt to add time namespace support to clone3(). I am not
> > really sure which way clone3() should handle time namespaces. The time
> > namespace through /proc cannot be used with clone3() because the offsets
> > for the time namespace need to be written before a process has been
> > created in that time namespace. This means it is necessary to somehow
> > tell clone3() the offsets for the clocks.
> >
> > The time namespace offers the possibility to set offsets for
> > CLOCK_MONOTONIC and CLOCK_BOOTTIME. My first approach was to extend
> > 'struct clone_args` with '__aligned_u64 monotonic_offset' and
> > '__aligned_u64 boottime_offset'. The problem with this approach was that
> > it was not possible to set nanoseconds for the clocks in the time
> > namespace.
> >
> > One of the motivations for clone3() with CLONE_NEWTIME was to enable
> > CRIU to restore a process in a time namespace with the corresponding
> > offsets. And although the nanosecond value can probably never be
> > restored to the same value it had during checkpointing, because the
> > clock keeps on running between CRIU pausing all processes and CRIU
> > actually reading the value of the clocks, the nanosecond value is still
> > necessary for CRIU to not restore a process where the clock jumps back
> > due to CRIU restoring it with a nanonsecond value that is too small.
> >
> > Requiring nanoseconds as well as seconds for two clocks during clone3()
> > means that it would require 4 additional members to 'struct clone_args':
> >
> >         __aligned_u64 tls;
> >         __aligned_u64 set_tid;
> >         __aligned_u64 set_tid_size;
> > +       __aligned_u64 boottime_offset_seconds;
> > +       __aligned_u64 boottime_offset_nanoseconds;
> > +       __aligned_u64 monotonic_offset_seconds;
> > +       __aligned_u64 monotonic_offset_nanoseconds;
> >  };
> 
> Wouldn't it be sufficient to have the two nanosecond values, rather
> than both seconds and nanoseconds? With 64-bit nanoseconds
> you can represent several hundred years, and these would
> always start at zero during boot.

I like this. Just using nanoseconds will make it easier and should
indeed be enough.

> Regardless of this, I think you need a signed offset, not unsigned.

Right, that was just a quick test at some point.

Christian and I have also been discussing this a bit and Christian
prefers a pointer to a struct. Maybe something like this:

        __aligned_u64 tls;
        __aligned_u64 set_tid;
        __aligned_u64 set_tid_size;
+       __aligned_u64 timens_offset;
 };

With Arnd's idea of only using nanoseconds, timens_offset would then
contain something like this:

struct timens_offset {
	__aligned_s64 monotonic_offset_ns;
	__aligned_s64 boottime_offset_ns;
};

I kind of prefer adding boottime and monotonic directly to struct clone_args

        __aligned_u64 tls;
        __aligned_u64 set_tid;
        __aligned_u64 set_tid_size;
+       __aligned_s64 monotonic_offset_ns;
+       __aligned_s64 boottime_offset_ns;
 };

But setting the time namespace offset is probably something which does
not happen very often while using clone3(), so maybe the pointer to a
struct approach is better.

I will resend the patches using the pointer to a struct approach if
there are no other ideas how to do this.

		Adrian

