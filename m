Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E589B74B58
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfGYKQb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 06:16:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfGYKQb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 25 Jul 2019 06:16:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB1B4756;
        Thu, 25 Jul 2019 10:16:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id D97C561F21;
        Thu, 25 Jul 2019 10:16:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Jul 2019 12:16:30 +0200 (CEST)
Date:   Thu, 25 Jul 2019 12:16:27 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
Message-ID: <20190725101626.GD4707@redhat.com>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724144651.28272-3-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 10:16:31 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 07/24, Christian Brauner wrote:
>
> +SYSCALL_DEFINE6(pidfd_wait, int, pidfd, int __user *, stat_addr,
> +		siginfo_t __user *, info, struct rusage __user *, ru,
> +		unsigned int, states, unsigned int, flags)
> +{

Oh, I too think that P_PIDFD makes more sense.

and could you explain in the changelog why? I am not arguing and if
nothing else this is consistent with other pidfd features, but if you
are parent/debugger you can't hit the problem with pid-reuse, unless
you races with your sub-threads.

Oleg.

