Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DCB25FC1F
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgIGObY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 10:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729892AbgIGOac (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 10:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599489023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUG8cF3p9BM+fhUV3H/SKqqivV8JS8s0QdlQ+W61fOo=;
        b=JQkWRk6FcIQ/3HI9IKi7PVZ7A3yYF9ngqoFqv1YB+vgqi/tFiPenW4BXmxxI4ovdSayjd0
        zRUz6p5KuGhSfAQJKz1OAofLEido9Fx+ng8ITUF6u01Ok8alSj2YY8kVb9sV0cUdxtVDdy
        r4MNn4tUJPihVc0+3sUx0/sfIlnHf3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-2e9iq7GyNg28Jr_RLdFH0g-1; Mon, 07 Sep 2020 10:30:19 -0400
X-MC-Unique: 2e9iq7GyNg28Jr_RLdFH0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E63368015A8;
        Mon,  7 Sep 2020 14:30:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id A419B78390;
        Mon,  7 Sep 2020 14:30:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  7 Sep 2020 16:30:16 +0200 (CEST)
Date:   Mon, 7 Sep 2020 16:30:08 +0200
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
Message-ID: <20200907143008.GB31050@redhat.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-5-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904113116.20648-5-alazar@bitdefender.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

it seems that nobody is going to review this patch ;)

So I tried to read mirror_vm_fault() and the usage of mmap_sem doesn't
look right to me. But let me repeat, this is not my area I can be easily
wrong, please correct me.

On 09/04, Adalbert Lazăr wrote:
>
> +static vm_fault_t mirror_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct remote_vma_context *ctx = vma->vm_private_data;
> +	struct remote_view *view = ctx->view;
> +	struct file *file = vma->vm_file;
> +	struct remote_file_context *fctx = file->private_data;
> +	unsigned long req_addr;
> +	unsigned int gup_flags;
> +	struct page *req_page;
> +	vm_fault_t result = VM_FAULT_SIGBUS;
> +	struct mm_struct *src_mm = fctx->mm;
> +	unsigned long seq;
> +	int idx;
> +
> +fault_retry:
> +	seq = mmu_interval_read_begin(&view->mmin);
> +
> +	idx = srcu_read_lock(&fctx->fault_srcu);
> +
> +	/* check if view was invalidated */
> +	if (unlikely(!READ_ONCE(view->valid))) {
> +		pr_debug("%s: region [%lx-%lx) was invalidated!!\n", __func__,
> +			view->offset, view->offset + view->size);
> +		goto out_invalid;		/* VM_FAULT_SIGBUS */
> +	}
> +
> +	/* drop current mm semapchore */
> +	up_read(&current->mm->mmap_sem);

Please use mmap_read_lock/unlock(mm) instead of down/up_read(mmap_sem).

But why is it safe to drop ->mmap_sem without checking
FAULT_FLAG_ALLOW_RETRY/RETRY_NOWAIT ?

> +	/* take remote mm semaphore */
> +	if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
> +		if (!down_read_trylock(&src_mm->mmap_sem)) {

I don't understand this... perhaps you meant FAULT_FLAG_RETRY_NOWAIT ?

> +	 * If FAULT_FLAG_ALLOW_RETRY is set, the mmap_sem must be released
> +	 * before returning VM_FAULT_RETRY only if FAULT_FLAG_RETRY_NOWAIT is
> +	 * not set.

Well, iiuc FAULT_FLAG_ALLOW_RETRY means that ->fault() _can_ drop mmap_sem
and return VM_FAULT_RETRY (unless NOWAIT).

> +	if (vmf->flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_TRIED)) {
> +		if (!(vmf->flags & FAULT_FLAG_KILLABLE))
> +			if (current && fatal_signal_pending(current)) {
> +				up_read(&current->mm->mmap_sem);
> +				return VM_FAULT_RETRY;

I fail to understand this. But in any case, you do not need to check
current != NULL and up_read() looks wrong if RETRY_NOWAIT?

Oleg.

