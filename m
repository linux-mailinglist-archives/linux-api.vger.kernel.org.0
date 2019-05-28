Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2150E2D250
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfE1XQy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 19:16:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46340 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfE1XQy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 19:16:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id j49so116490otc.13
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXl2E+8Ofltdc9I18xpTcw4iLvgqqVUYnnHUQU/GAq8=;
        b=XRdrVhMlsJz9dk8XMaJIhK71SNkpeN9/QvL1IFjjOGQL/+2erDzADKEgV2Ewf7N9BF
         cBCn7ujn+0ZSADdUtnYM6bYVxPorxwZmenlFR6nyf9F/usl1rHTU5jsCrmubxLZEOeF7
         uRjdac8tx++6S7JxCvvB/zFu9U6mVc3a/709+2v6vE/NBRNH2hn7NoBGlSOHT+Q/oVOM
         k5Cx0qcxzwFTZr1V8SKiSavDEM/adYJcvqzB44X2L5HuR5ZNGPugOczgP0sw2Cfrx284
         dR12tmV/bA+xqSC+omGlF6HiNYF/bLaYcY4gsz2/oJYnVJIp1XXgxJZqzBh0SHcI77fo
         4PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXl2E+8Ofltdc9I18xpTcw4iLvgqqVUYnnHUQU/GAq8=;
        b=oraUC4HTvQz0SsSMqr8B86yABsrU3CSQevUVJfNz2QR+ApSENLEUps5GbwvB1D4ojb
         W2JH0hjkzNXvYkD6ZNU3YkIQE7py44a/yS3sqd9DFWnige6YWo4OvGDooMEXIYpdDi+T
         7Y9MXgOJ8QGsSkXthSfh8VJMNHHpNESWzfrUBLhf7AYIyxncdBPZYKBuR7pV+V2sailo
         1Y5h+xDYbbluzWVBlimJ63czfS8UlT/x2gI0VEVdAIKJHtlIwkzcHJEuUn9Y0jDZVpee
         WbDs4vsKDy6B06o8jauikRQlgbw/xTXySVlltAFrbAj3AMX9HuiK1fcL4GgnRXmwDxOR
         loaQ==
X-Gm-Message-State: APjAAAXNLUxk0OlpCv57JVEJus0K7ybPALqmcKQhY0Ekq+F/jh2hWmU5
        qMNydpI6HzQGszwd1GiPwShmhS8Wyq52fVCFZPL3/A==
X-Google-Smtp-Source: APXvYqxAIU+CfyUKrIQH2tqs54n2YHk/dG4f/kR15R8K49NvXBnA+Zac0GblhA3C6ht8PtVupw/K3bwfpeGSx+t1xGU=
X-Received: by 2002:a9d:6254:: with SMTP id i20mr27881970otk.180.1559085412912;
 Tue, 28 May 2019 16:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <CAG48ez3L5KzKyKMxUTaaB=r1E1ZXh=m6e9+CwYcXfRnUSjDvWA@mail.gmail.com> <11466.1559082515@warthog.procyon.org.uk>
In-Reply-To: <11466.1559082515@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 01:16:26 +0200
Message-ID: <CAG48ez3W=Og7_9P9X6fatkCw4Zwbz-N35wRGFFNK8q9k0qL5iw@mail.gmail.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 29, 2019 at 12:28 AM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > I don't see you setting any special properties on the VMA that would
> > prevent userspace from extending its size via mremap() - no
> > VM_DONTEXPAND or VM_PFNMAP. So I think you might get an out-of-bounds
> > access here?
>
> Should I just set VM_DONTEXPAND in watch_queue_mmap()?  Like so:
>
>         vma->vm_flags |= VM_DONTEXPAND;

Yeah, that should work.

> > > +static void watch_queue_map_pages(struct vm_fault *vmf,
> > > +                                 pgoff_t start_pgoff, pgoff_t end_pgoff)
> > ...
> >
> > Same as above.
>
> Same solution as above?  Or do I need ot check start/end_pgoff too?

Same solution.

> > > +static int watch_queue_mmap(struct file *file, struct vm_area_struct *vma)
> > > +{
> > > +       struct watch_queue *wqueue = file->private_data;
> > > +
> > > +       if (vma->vm_pgoff != 0 ||
> > > +           vma->vm_end - vma->vm_start > wqueue->nr_pages * PAGE_SIZE ||
> > > +           !(pgprot_val(vma->vm_page_prot) & pgprot_val(PAGE_SHARED)))
> > > +               return -EINVAL;
> >
> > This thing should probably have locking against concurrent
> > watch_queue_set_size()?
>
> Yeah.
>
>         static int watch_queue_mmap(struct file *file,
>                                     struct vm_area_struct *vma)
>         {
>                 struct watch_queue *wqueue = file->private_data;
>                 struct inode *inode = file_inode(file);
>                 u8 nr_pages;
>
>                 inode_lock(inode);
>                 nr_pages = wqueue->nr_pages;
>                 inode_unlock(inode);
>
>                 if (nr_pages == 0 ||
>                 ...
>                         return -EINVAL;

Looks reasonable.

> > > +       smp_store_release(&buf->meta.head, len);
> >
> > Why is this an smp_store_release()? The entire buffer should not be visible to
> > userspace before this setup is complete, right?
>
> Yes - if I put the above locking in the mmap handler.  OTOH, it's a one-off
> barrier...
>
> > > +               if (wqueue->buffer)
> > > +                       return -EBUSY;
> >
> > The preceding check occurs without any locks held and therefore has no
> > reliable effect. It should probably be moved below the
> > inode_lock(...).
>
> Yeah, it can race.  I'll move it into watch_queue_set_size().

Sounds good.

> > > +static void free_watch(struct rcu_head *rcu)
> > > +{
> > > +       struct watch *watch = container_of(rcu, struct watch, rcu);
> > > +
> > > +       put_watch_queue(rcu_access_pointer(watch->queue));
> >
> > This should be rcu_dereference_protected(..., 1).
>
> That shouldn't be necessary.  rcu_access_pointer()'s description says:
>
>  * It is also permissible to use rcu_access_pointer() when read-side
>  * access to the pointer was removed at least one grace period ago, as
>  * is the case in the context of the RCU callback that is freeing up
>  * the data, ...
>
> It's in an rcu callback function, so accessing the __rcu pointers in the RCU'd
> struct should be fine with rcu_access_pointer().

Aah, whoops, you're right, I missed that paragraph in the
documentation of rcu_access_pointer().

> > > +       /* We don't need the watch list lock for the next bit as RCU is
> > > +        * protecting everything from being deallocated.
> >
> > Does "everything" mean "the wqueue" or more than that?
>
> Actually, just 'wqueue' and its buffer.  'watch' is held by us once we've
> dequeued it as we now own the ref 'wlist' had on it.  'wlist' and 'wq' must be
> pinned by the caller.
>
> > > +                       if (release) {
> > > +                               if (wlist->release_watch) {
> > > +                                       rcu_read_unlock();
> > > +                                       /* This might need to call dput(), so
> > > +                                        * we have to drop all the locks.
> > > +                                        */
> > > +                                       wlist->release_watch(wlist, watch);
> >
> > How are you holding a reference to `wlist` here? You got the reference through
> > rcu_dereference(), you've dropped the RCU read lock, and I don't see anything
> > that stabilizes the reference.
>
> The watch record must hold a ref on the watched object if the watch_list has a
> ->release_watch() method.  In the code snippet above, the watch record now
> belongs to us because we unlinked it under the wlist->lock some lines prior.

Ah, of course.

> However, you raise a good point, and I think the thing to do is to cache
> ->release_watch from it and not pass wlist into (*release_watch)().  We don't
> need to concern ourselves with cleaning up *wlist as it will be cleaned up
> when the target object is removed.
>
> Keyrings don't have a ->release_watch method and neither does the block-layer
> notification stuff.
>
> > > +       if (wqueue->pages && wqueue->pages[0])
> > > +               WARN_ON(page_ref_count(wqueue->pages[0]) != 1);
> >
> > Is there a reason why there couldn't still be references to the pages
> > from get_user_pages()/get_user_pages_fast()?
>
> I'm not sure.  I'm not sure what to do if there are.  What do you suggest?

I would use put_page() instead of manually freeing it; I think that
should be enough? I'm not entirely sure though.

> > > +       n->info &= (WATCH_INFO_LENGTH | WATCH_INFO_TYPE_FLAGS | WATCH_INFO_ID);
> >
> > Should the non-atomic modification of n->info
>
> n's an unpublished copy of some userspace data that's local to the function
> instance.  There shouldn't be any way to race with it at this point.

Ah, derp. Yes.
