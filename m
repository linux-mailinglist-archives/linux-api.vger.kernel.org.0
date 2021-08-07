Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110C43E35F0
	for <lists+linux-api@lfdr.de>; Sat,  7 Aug 2021 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhHGOsh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 7 Aug 2021 10:48:37 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55424 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhHGOsg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 7 Aug 2021 10:48:36 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9291B72C8F8;
        Sat,  7 Aug 2021 17:48:17 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 73BE57CF71A; Sat,  7 Aug 2021 17:48:17 +0300 (MSK)
Date:   Sat, 7 Aug 2021 17:48:17 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry V. Levin" <ldv@strace.io>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] uapi: expose enum pid_type as enum __kernel_pidtype
Message-ID: <20210807144817.GC11597@altlinux.org>
References: <20210807120905.GA14706@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807120905.GA14706@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 07, 2021 at 02:09:05PM +0200, Eugene Syromiatnikov wrote:
> Commit 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
> made use of enum pid_type in prctl's arg4;  however, this type
> and the associated enumeration definitions are not exposed to userspace.
> Try to fix that by providing enum __kernel_pidtype and tying in-kernel
> enum pid_type definitions to it.  Note that enum pid_type cannot be exposed
> as is, since "enum pid_type" is already exists in various projects [1]

Grammar: "enum pid_type" already exists.

> (notably gcc and strace), and "enum __pid_type" is defined by glibc and uclibc
> for fcntl(F_SETOWN_EX) owner ID type;  there is also __kernel_pid_t,
> that looks too similar to __kernel_pid_type.
> 
> [1] https://codesearch.debian.net/search?q=enum+pid_type
> 
> Complements: 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>


-- 
ldv
