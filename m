Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB321A0C33
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDGKnX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 06:43:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGKnX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 06:43:23 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jLlhQ-0006uP-Cg; Tue, 07 Apr 2020 10:43:20 +0000
Date:   Tue, 7 Apr 2020 12:43:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Vagin <avagin@openvz.org>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Subject: Re: [PATCH] kernel/time: Add max_time_namespaces ucount
Message-ID: <20200407104319.mrknabgzmmraxk22@wittgenstein>
References: <20200406171342.128733-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406171342.128733-1-dima@arista.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 06, 2020 at 06:13:42PM +0100, Dmitry Safonov via Containers wrote:
> Introduce missing time namespaces limit per-userns.
> Michael noticed that userns limit for number of time namespaces is
> missing.
> 
> Furthermore, time namespace introduced UCOUNT_TIME_NAMESPACES, but
> didn't introduce an array member in user_table[]. It would make array's
> initialisation OOB write, but by luck the user_table array has
> an excessive empty member (all accesses to the array are limited with
> UCOUNT_COUNTS - so it silently reuses the last free member.
> 
> Fixes user-visible regression: max_inotify_instances by reason of the
> missing UCOUNT_ENTRY() has limited max number of namespaces instead of
> the number of inotify instances.
> 
> Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
> Cc: Adrian Reber <adrian@lisas.de>
> Cc: Andrey Vagin <avagin@openvz.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Containers <containers@lists.linux-foundation.org>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: stable@kernel.org # v5.6+
> Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
