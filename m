Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD913E3506
	for <lists+linux-api@lfdr.de>; Sat,  7 Aug 2021 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhHGLBg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 7 Aug 2021 07:01:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43134 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhHGLBc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 7 Aug 2021 07:01:32 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3AA4072C8F8;
        Sat,  7 Aug 2021 14:01:13 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 2BC177CF71A; Sat,  7 Aug 2021 14:01:13 +0300 (MSK)
Date:   Sat, 7 Aug 2021 14:01:13 +0300
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
Subject: Re: [PATCH v2] uapi: expose enum pid_type as enum __kernel_pidtype
Message-ID: <20210807110113.GB9671@altlinux.org>
References: <20210807104800.GA22620@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807104800.GA22620@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Aug 07, 2021 at 12:48:00PM +0200, Eugene Syromiatnikov wrote:
[...]
> diff --git a/include/uapi/linux/pidtype.h b/include/uapi/linux/pidtype.h
> new file mode 100644
> index 0000000..2105ae3
> --- /dev/null
> +++ b/include/uapi/linux/pidtype.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_PID_H
> +#define _UAPI_LINUX_PID_H

Did you mean _UAPI_LINUX_PIDTYPE_H here?


-- 
ldv
