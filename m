Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5D35F97D
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhDNRJu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 13:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232604AbhDNRJu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 13:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618420168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=927x1OxFGjZhXg2hFqKXGTiskEIk6MxUpR4SI4f8vSc=;
        b=W5f7+DuyfPixkrpUJJqMOqEKUQ20dt1N1sVQQlXkgZOD9i2/OXkJLHIrMl5iSZ+8maTHzN
        rLUSucmvKu/2u6DLBs40UG+JGegu/ZBysmeVCnOOYW3bzhOsUz1fvIMb74NqNwmV8KyFDj
        MSUEtgEwt4EikhvjTladlWY5GHGLTJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-DLv3OehOMWuiZSgOgEctCg-1; Wed, 14 Apr 2021 13:09:24 -0400
X-MC-Unique: DLv3OehOMWuiZSgOgEctCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9479C6D241;
        Wed, 14 Apr 2021 17:09:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id A382E5D6A8;
        Wed, 14 Apr 2021 17:09:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Apr 2021 19:09:21 +0200 (CEST)
Date:   Wed, 14 Apr 2021 19:09:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <20210414170915.GB22294@redhat.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414055217.543246-3-avagin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/13, Andrei Vagin wrote:
>
> +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> +{
> +	struct task_struct *tsk = current;
> +	struct mm_struct *active_mm;
> +
> +	task_lock(tsk);
> +	/* Hold off tlb flush IPIs while switching mm's */
> +	local_irq_disable();
> +
> +	sync_mm_rss(prev_mm);
> +
> +	vmacache_flush(tsk);
> +
> +	active_mm = tsk->active_mm;
> +	if (active_mm != target_mm) {
> +		mmgrab(target_mm);
> +		tsk->active_mm = target_mm;
> +	}
> +	tsk->mm = target_mm;
> +	switch_mm_irqs_off(active_mm, target_mm, tsk);
> +	local_irq_enable();
> +	task_unlock(tsk);
> +#ifdef finish_arch_post_lock_switch
> +	finish_arch_post_lock_switch();
> +#endif
> +
> +	if (active_mm != target_mm)
> +		mmdrop(active_mm);
> +}

I think this should be unified with kthread_use_mm() somehow...

And does it really need the "prev_mm" argument? It must be tsk->mm, no?

Oleg.

