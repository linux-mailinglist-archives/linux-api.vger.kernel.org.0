Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F425FCCE
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgIGPQi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 11:16:38 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:43950 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730081AbgIGPQc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 11:16:32 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id 922FF30747BE;
        Mon,  7 Sep 2020 18:16:03 +0300 (EEST)
Received: from localhost (unknown [195.189.155.252])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id 679503038E24;
        Mon,  7 Sep 2020 18:16:03 +0300 (EEST)
From:   Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RESEND RFC PATCH 4/5] mm/remote_mapping: use a pidfd to access
 memory belonging to unrelated process
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?UTF-8?b?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
In-Reply-To: <20200907143008.GB31050@redhat.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
        <20200904113116.20648-5-alazar@bitdefender.com>
        <20200907143008.GB31050@redhat.com>
Date:   Mon, 07 Sep 2020 18:16:30 +0300
Message-ID: <15994917900.dEaCB.18501@host>
User-agent: void
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 7 Sep 2020 16:30:08 +0200, Oleg Nesterov <oleg@redhat.com> wrote:
> it seems that nobody is going to review this patch ;)
> 
> So I tried to read mirror_vm_fault() and the usage of mmap_sem doesn't
> look right to me. But let me repeat, this is not my area I can be easily
> wrong, please correct me.
> 
> On 09/04, Adalbert Lazăr wrote:
> >
> > +static vm_fault_t mirror_vm_fault(struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct remote_vma_context *ctx = vma->vm_private_data;
> > +	struct remote_view *view = ctx->view;
> > +	struct file *file = vma->vm_file;
> > +	struct remote_file_context *fctx = file->private_data;
> > +	unsigned long req_addr;
> > +	unsigned int gup_flags;
> > +	struct page *req_page;
> > +	vm_fault_t result = VM_FAULT_SIGBUS;
> > +	struct mm_struct *src_mm = fctx->mm;
> > +	unsigned long seq;
> > +	int idx;
> > +
> > +fault_retry:
> > +	seq = mmu_interval_read_begin(&view->mmin);
> > +
> > +	idx = srcu_read_lock(&fctx->fault_srcu);
> > +
> > +	/* check if view was invalidated */
> > +	if (unlikely(!READ_ONCE(view->valid))) {
> > +		pr_debug("%s: region [%lx-%lx) was invalidated!!\n", __func__,
> > +			view->offset, view->offset + view->size);
> > +		goto out_invalid;		/* VM_FAULT_SIGBUS */
> > +	}
> > +
> > +	/* drop current mm semapchore */
> > +	up_read(&current->mm->mmap_sem);
> 
> Please use mmap_read_lock/unlock(mm) instead of down/up_read(mmap_sem).

This patch series is based on 5.7-rc2.
The cover letter has base-commit: present, but I forgot to mention this
explicitly, sorry.

Adalbert
