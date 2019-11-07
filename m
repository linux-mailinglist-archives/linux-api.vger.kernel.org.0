Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6AF305E
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 14:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfKGNsD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 08:48:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388913AbfKGNsD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 08:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573134481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KOQyTjrXeO2BATDacaFvE++gK4mhw32+/Fp+qiwNH4=;
        b=gcAvgyiWeWBeUx1jU9jSpwqS5pG8sEqwNaGGvB+uyEfolBF9tPSHjUGN/EBvwcPzXRqPPB
        SGfDts6zz2emC699DafGeNPaenY0ED2VOgFCXf9D80gbdQocoTrKmEcTy1sQ56br0U2OXW
        34CRLkETDkv4sS0o6WreKTGBDnnoniQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-5qXTb8wmOhiU0B-FsjWN9A-1; Thu, 07 Nov 2019 08:47:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B51D1800D7B;
        Thu,  7 Nov 2019 13:47:57 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 438055D6A0;
        Thu,  7 Nov 2019 13:47:56 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Elichai Turkel <elichai.turkel@gmail.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Continuing the UAPI split
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
        <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
        <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
        <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
        <87zhh7hlbl.fsf@oldenburg2.str.redhat.com>
        <20191107133652.lqp5cqcdtwu22ibd@wittgenstein>
Date:   Thu, 07 Nov 2019 14:47:54 +0100
In-Reply-To: <20191107133652.lqp5cqcdtwu22ibd@wittgenstein> (Christian
        Brauner's message of "Thu, 7 Nov 2019 14:36:54 +0100")
Message-ID: <87v9rvhk6t.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5qXTb8wmOhiU0B-FsjWN9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner:

> A problem I recently ran into that is related are problems with
> sys/wait.h and linux/wait.h.
> How P_{PID,PGID,PIDFD} used by the waitid() syscall are defined is
> different for the two headers.
> linux/wait.h uses #define for P_{PID,PGID,PIDFD} whereas sys/wait.h
> uses an enum.
> The problem is that if I simply don't rely on sys/wait.h and just do
> #ifndef P_PID
> #define P_PID <value>
> #endif
> where value is what the syscall expects then technically I need to call
> the waitid() syscall directly since it's not at all guaranteed - afaict
> - that the P_PID enum =3D=3D P_PID define that glibc uses for its waitid(=
)
> syscall wrapper.

Right, and this is where POSIX mandates that there is a type idtype_t
which is an enum, an that it has members P_PID etc.

What we could do is:

typedef enum
{
  P_ALL,=09=09/* Wait for any child.  */
#define P_ALL P_ALL
  P_PID,=09=09/* Wait for specified process.  */
#define P_PID P_PID
  P_PGID=09=09/* Wait for members of process group.  */
#define P_PGID P_PGID
} idtype_t;

The other header can then use #ifdef.  You'll see that pattern in some
cases already.

But that will only work if you include glibc headers first.  The generic
approach uses some shared macro for the coordination so that things work
both ways.

The other issue here is that it gets rather iffy from a language point
of view if the kernel wants to add additional constants and glibc has
still the old idtype_t definition.

> So I'm now in a scenario where I can't call the glibc wrapper for
> waitid() with the linux/wait.h defines and I can't call the syscall
> directly (e.g. because I want to make use of the syscall's rusage
> argument that glibc doesn't expose) with sys/wait.h's P_PID enum.
> I'm not sure what the right solution is here...

Yes, it's a hard problem.  waitid is particularly annoying because POSIX
and the kernel have such different function prototypes.  We could
perhaps expose the actual waitid system call under a different name, and
use int for the ID type parameter.  But that needs someone to write a
patch.  (My efforts to add syscall wrappers have stalled unfortunately.)

Thanks,
Florian

