Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB725E134
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgIDRzU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 13:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgIDRzU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 13:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599242119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xZGtz6AqO5FwybZw0tM4AMKqTLxgkhwTmRA2SACMi8=;
        b=EKwpgbuE16JQfVHJKxM4dajL3xnRgBur54l7fsmS4099nEKqgtiQ4csIckgVEpI7LpeJzC
        7bTPKgsDq56Pjbs9iyam02l49y81aO0+iqMQ0h+/0nycrdj8rm9euya6NNDevRjeJwgP3n
        +XASPRIcEPqANARJYsj4Cp5fe4uNyyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-Lh8-13ZoPIq-CVdzHV9TKg-1; Fri, 04 Sep 2020 13:55:15 -0400
X-MC-Unique: Lh8-13ZoPIq-CVdzHV9TKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF2C7801AB8;
        Fri,  4 Sep 2020 17:55:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id E2F145C1D0;
        Fri,  4 Sep 2020 17:55:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  4 Sep 2020 19:55:12 +0200 (CEST)
Date:   Fri, 4 Sep 2020 19:55:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
Message-ID: <20200904175503.GO4386@redhat.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-5-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904113116.20648-5-alazar@bitdefender.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I didn't read this series. This is not my area and to be honest even
the API doesn't fit my head. I leave this to other reviewers.

Just a couple of nits after very quick glance.

On 09/04, Adalbert Lazăr wrote:
>
> +static vm_fault_t mirror_vm_fault(struct vm_fault *vmf)
> +{
...

> +	up_read(&current->mm->mmap_sem);

...

> +	down_read(&current->mm->mmap_sem);
> +
> +	/* expedite retry */
> +	if (mmu_interval_check_retry(&view->mmin, seq)) {
> +		put_page(req_page);
> +
> +		srcu_read_unlock(&fctx->fault_srcu, idx);
> +
> +		goto fault_retry;
> +	}
> +
> +	/* make sure the VMA hasn't gone away */
> +	vma = find_vma(current->mm, vmf->address);
> +	if (vma == vmf->vma) {

vmf->vma can go away, its memory can be freed and re-allocated as another
vma returned by find_vma() above.

> +int task_remote_map(struct task_struct *task, int fds[])
> +{

...

> +	fds[1] = anon_inode_getfd("[pidfd_mem.map]", &pidfd_mem_map_fops, fctx,
> +				  O_RDWR | O_CLOEXEC | O_LARGEFILE);
> +	if (fds[1] < 0) {
> +		ret = fds[1];
> +		goto out;
> +	}
> +	remote_file_context_get(fctx);
> +
> +	map = fget(fds[1]);

Another thread can close this file right after fd_install(). fget() can return
NULL or another unrelated file.

Oleg.

