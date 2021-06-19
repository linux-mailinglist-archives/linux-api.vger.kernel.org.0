Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760203AD655
	for <lists+linux-api@lfdr.de>; Sat, 19 Jun 2021 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhFSApf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Jun 2021 20:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhFSApe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Jun 2021 20:45:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC766C061574
        for <linux-api@vger.kernel.org>; Fri, 18 Jun 2021 17:43:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bb20so2515026pjb.3
        for <linux-api@vger.kernel.org>; Fri, 18 Jun 2021 17:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7s9WvbJkqKhCNp+zP4zH5s3aBLko94DMgPFH1zonS9k=;
        b=X5tsLekqhkt5ZAfhcwjLxVkCIhWWGWyFrUqo+zXkbWVAqw7zFDxQJpQajV3c5Zkght
         /izvXct8sWn/ST4UiXGHvviVtzlaMe73F+CIEbPJFJtNTmYE59f0qxrznXWzMS7wRzut
         fNqI1E/4hBX917pEM/NHfl4ES5WCgiEwhjzs6/wo31i7HwDw42KmPybL1s+YKwQaT5/Y
         jZDhQXvm0AJ0v5vu6dcV51K1wzQHDFUDFn7X17k0dmaoCa86D9ksQxwdk4Te9PBUosRW
         +eT3czudcFwUKmMg92NhqPrR3QJad2xTDaFvcN+omSCR/sae4uSAXTbaJGlrqGSK12xI
         aOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7s9WvbJkqKhCNp+zP4zH5s3aBLko94DMgPFH1zonS9k=;
        b=HqZ54SQ4wAwzYe9V43oijWTptwyFMw/JYyA3g1UYovCTUOytoJ4pqFW1Do2W4cfTxp
         Rpm1N8ytHuNj/P+/pM8+W7h3avfiAXd4XKBHlK+yse8SnL9lhweFtqLJiNHokZphC0es
         j2N1dkNaDUF40ou2MMlQQ/KQRsdGf8ffVes/GUOk7cw6GJ5YttEnLdAuuxsyYEWDXwrb
         9CIWHAKoBggC/SfPJHan4Xier3+HwgRiGupXv1FKJ2PLljy1H7PHKNyOt/BxyefgWk73
         tY+oDfPF0TTHBfAhG1lVBbxRtr/l6RZU6PD4XbqL5Ujjpja5NvCPB2oZnH3Mj7TNjHl3
         NiaQ==
X-Gm-Message-State: AOAM530SYd5lz94tedpblc8O8Vb/FIBuR0M9Ycd6ZEEEjNm6Uj2iP/cO
        XYnSG9U6bA3uyA4Chfv+7KsHBQ==
X-Google-Smtp-Source: ABdhPJyKpSD8EvYengKDA/eCNasZnZcsFnhZy+bH9v2g2zKaQZ9ToHx3SeDLgXiiZLb47uifa1YJkA==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr6972494plh.11.1624063404170;
        Fri, 18 Jun 2021 17:43:24 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:41cb])
        by smtp.gmail.com with ESMTPSA id v1sm8425835pjg.19.2021.06.18.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 17:43:23 -0700 (PDT)
Date:   Fri, 18 Jun 2021 17:43:21 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM09qaP3qATwoLTJ@relinquished.localdomain>
References: <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 18, 2021 at 10:32:54PM +0000, Al Viro wrote:
> On Fri, Jun 18, 2021 at 03:10:03PM -0700, Omar Sandoval wrote:
> 
> > Or do the same reverting thing that Al did, but with copy_from_iter()
> > instead of copy_from_iter_full() and being careful with the copied count
> > (which I'm not 100% sure I got correct here):
> > 
> > 	size_t copied = copy_from_iter(&encoded, sizeof(encoded), &i);
> > 	if (copied < offsetofend(struct encoded_iov, size))
> > 		return -EFAULT;
> > 	if (encoded.size > PAGE_SIZE)
> > 		return -E2BIG;
> > 	if (encoded.size < ENCODED_IOV_SIZE_VER0)
> > 		return -EINVAL;
> > 	if (encoded.size > sizeof(encoded)) {
> > 		if (copied < sizeof(encoded)
> > 			return -EFAULT;
> > 		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
> > 			return -EINVAL;
> > 	} else if (encoded.size < sizeof(encoded)) {
> > 		// older than what we expect
> > 		if (copied < encoded.size)
> > 			return -EFAULT;
> > 		iov_iter_revert(&i, copied - encoded.size);
> > 		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
> > 	}    
> 
> simpler than that, actually -
> 
> 	copied = copy_from_iter(&encoded, sizeof(encoded), &i);
> 	if (unlikely(copied < sizeof(encoded))) {
> 		if (copied < offsetofend(struct encoded_iov, size) ||
> 		    copied < encoded.size)
> 			return iov_iter_count(i) ? -EFAULT : -EINVAL;
> 	}
> 	if (encoded.size > sizeof(encoded)) {
> 		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
> 			return -EINVAL;
> 	} else if (encoded.size < sizeof(encoded)) {
> 		// copied can't be less than encoded.size here - otherwise
> 		// we'd have copied < sizeof(encoded) and the check above
> 		// would've buggered off
> 		iov_iter_revert(&i, copied - encoded.size);
> 		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
> 	}
> 
> should do it.

Thanks, Al, I'll send an updated version with this approach next week.
