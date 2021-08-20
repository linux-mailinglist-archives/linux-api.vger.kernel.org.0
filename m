Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980C53F3247
	for <lists+linux-api@lfdr.de>; Fri, 20 Aug 2021 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhHTRcS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Aug 2021 13:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbhHTRcR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Aug 2021 13:32:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253EC061757
        for <linux-api@vger.kernel.org>; Fri, 20 Aug 2021 10:31:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mq3so7753214pjb.5
        for <linux-api@vger.kernel.org>; Fri, 20 Aug 2021 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hausAV75QDfnkXVBVC/RcV475eLvboVMKfHjcdo1TZ0=;
        b=p+XcEkMrdKp6ZS4EVumBBINKww5sw0P4gqnLC5q56jK1VfTqgDaRo1rsqLhwZvydLw
         5j8ppl+MaJcNf43LfLSHPMsJURSRtzZmIYZMhlcAXpsM+ALjlrlhZyOhmCqnIwULb4xF
         6yB3AEhV8cNVUgog4kzuADIS52L84AP+ZgjY6nnwj49NJp2TWjfq1hIPOs54Zu4GK/0j
         oQ3r044con7YQA1FzGM/0pzLB4Ji/kZlKoTbVdMov7ITDwDjCNQpmYadoCr/Wk0w6Rf+
         4i7ohJDZb6Dkw1ZOo4fVGmvj3D4P5JbDUioQ5PBaAHkVrP0QzFI2RKijvZzoF13KctNC
         P/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hausAV75QDfnkXVBVC/RcV475eLvboVMKfHjcdo1TZ0=;
        b=kcCeE+osROPDP6vmoJp2G8DZ4OTYEqVr7+oKq575klWG9uvA/y9iD+y0h8Khs7uw3W
         1q72ZmyL4lGkFL5hoTwjSBeM7BbNQ6xIaHvqn4G+cfx3g3Z3MY4siNnfWjlLgxWLL30V
         c1AahYMoYmR7LhIYjlfWRVYzOwp9OKOnNpvgEtDnoLmhnNFEc7VYpx3PqKXV8rZ+wcQY
         ecmH7ANjyy0i7BQpgViQ+LkDutB2WDEbwfW48ZdvIQg1lnmej0k5yovFKh6fDBP56Oqf
         MN4lV/vZCIX1znVTmue/CItHUgHZyIrZPapJSuO0d3BX8WISIBvHFfG4M7Evoh14+6Ep
         YXMQ==
X-Gm-Message-State: AOAM531EQfivULL2pfx6PlenQyEsedt+8raGwTGRcQI8jrNdJPF4kO6r
        +uUM7OYwXsEuiCGuyNj1lbVbNA==
X-Google-Smtp-Source: ABdhPJxb423S2zbhxthqfJoLTc1GUl5giKYxZDtIxjcBC593fYLmbufbC2vlgZ0rQ8f42OskIWu8Bw==
X-Received: by 2002:a17:902:e891:b0:12d:97bf:b2d8 with SMTP id w17-20020a170902e89100b0012d97bfb2d8mr17144006plg.84.1629480698614;
        Fri, 20 Aug 2021 10:31:38 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id b15sm8763070pgj.60.2021.08.20.10.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:31:37 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:31:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 02/14] fs: export variant of generic_write_checks
 without iov_iter
Message-ID: <YR/m+IxihIBGm6Ps@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <237db7dc485834d3d359b5765f07ebf7c3514f3a.1629234193.git.osandov@fb.com>
 <ae6f8c7e-3b9b-bd95-140d-b556ce04df8f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae6f8c7e-3b9b-bd95-140d-b556ce04df8f@suse.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 20, 2021 at 10:59:28AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Encoded I/O in Btrfs needs to check a write with a given logical size
> > without an iov_iter that matches that size (because the iov_iter we have
> > is for the compressed data). So, factor out the parts of
> > generic_write_check() that expect an iov_iter into a new
> > __generic_write_checks() function and export that.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/read_write.c    | 40 ++++++++++++++++++++++------------------
> >  include/linux/fs.h |  1 +
> >  2 files changed, 23 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 0029ff2b0ca8..3bddd5ee7f64 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1633,6 +1633,26 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
> >  	return 0;
> >  }
> >  
> > +/* Like generic_write_checks(), but takes size of write instead of iter. */
> > +int __generic_write_checks(struct kiocb *iocb, loff_t *count)
> > +{
> > +	struct file *file = iocb->ki_filp;
> > +	struct inode *inode = file->f_mapping->host;
> > +
> > +	if (IS_SWAPFILE(inode))
> > +		return -ETXTBSY;
> 
>  Missing 'if(!count) return 0' from original code ?

Good catch, thanks.
