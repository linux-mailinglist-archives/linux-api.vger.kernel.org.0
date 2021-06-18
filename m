Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4193AD4DA
	for <lists+linux-api@lfdr.de>; Sat, 19 Jun 2021 00:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhFRWMZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Jun 2021 18:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhFRWMV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Jun 2021 18:12:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2418FC061768
        for <linux-api@vger.kernel.org>; Fri, 18 Jun 2021 15:10:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so1636292pjy.3
        for <linux-api@vger.kernel.org>; Fri, 18 Jun 2021 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yNhlQYTlXfpASragMq1YyqLYmcqVYazzT0gBUEUSDIM=;
        b=tkKOurHr4ja2uCUF8w9N29N9l1jDtAIIQGIyiy/39KLH2ftPzXNIre/kftyJ3wcnOe
         /Q/LglQl0Sn8fcsP03qYCwkPm726kMf4gs8s8gNCiu2/NqXbVzCUEXrZkq/WQvKhcBF1
         sNLbNdvvVWnSkodhW5cI0wQVpkASJ8nHKd8bUni4hLsGE5dFV6EFIvT9Hpyz6FaEP94Y
         PCHx0YLpuXVYh1BZtl8NNzpcMTOhuQ26+Ga7mOW3u5t1OyXSiWUYMBwkR3/lm388EfJC
         SbJRkhvvx0ZM7FE9COGS7etWZbZ/uE1YAQsQ/htdD5pfmebIub/I+ZdZeaIHyBGbXt7b
         APTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yNhlQYTlXfpASragMq1YyqLYmcqVYazzT0gBUEUSDIM=;
        b=p0wmyw2eZ5s/Q27Fa0n6M7HxqA2+nYoUrr09vJ1ETC/uYCexf/4MaAkBtioEnthV6B
         PCgY9H3JnhuGDME/IbBWtU9TOPhj4gxD4onx2Eagc7Q55P5fLK+gm1lupUB7rfObnmil
         gd9BREO7CpYnqrkCgKf8e5zGMsjwLIk21EfgSO1nm8lwDgN7ldUaP2I+8m9NiEvCtTts
         ZZxzaUdc2+ZeIeiSV1ZU0/iwq0EBhlxtrBWoh8FBOBj7lgiIBPkRumK+vpFR2tf1i1It
         vwbTTz+UM8E40wSXQf4lMm/6ovFjyE6ocNJN9Sgg9k5hI86QkCQbC2/S3/w9STKGGphW
         rJKQ==
X-Gm-Message-State: AOAM533Q7VolyDlsWgjmWTh1nGI2rHo97iM2fuaIJEiWYpBQArLPZoEU
        hIsfbWK4OJ6x8NScCFN4227GaQ==
X-Google-Smtp-Source: ABdhPJwt3UtPqCBT8vFD/+MGKBj7vyi0G51Fnu2utIE167L2OHFE77KMzz4+GK/QE/vgc7VvfHCrXw==
X-Received: by 2002:a17:902:b40e:b029:113:fbd6:3fe8 with SMTP id x14-20020a170902b40eb0290113fbd63fe8mr6626737plr.22.1624054206156;
        Fri, 18 Jun 2021 15:10:06 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:41cb])
        by smtp.gmail.com with ESMTPSA id gz14sm8617069pjb.18.2021.06.18.15.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:10:05 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:10:03 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YM0Zu3XopJTGMIO5@relinquished.localdomain>
References: <cover.1623972518.git.osandov@fb.com>
 <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk>
 <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
 <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 18, 2021 at 02:40:51PM -0700, Linus Torvalds wrote:
> On Fri, Jun 18, 2021 at 2:32 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Huh?  All corner cases are already taken care of by copy_from_iter{,_full}().
> > What I'm proposing is to have the size as a field in 'encoded' and
> > do this
> 
> Hmm. Making it part of the structure does make it easier (also for the
> sending userspace side, that doesn't now have to create yet another
> iov or copy the structure or whatever).
> 
> Except your code doesn't actually handle the "smaller than expected"
> case correctly, since by the time it even checks for that, it will
> possibly already have failed. So you actually had a bug there - you
> can't use the "xyz_full()" version and get it right.
> 
> That's fixable.

Right, we either need to read the size first and then the rest:

	size_t copy_size;
        if (!copy_from_iter_full(&encoded.size, sizeof(encoded.size),
				 &i))
                return -EFAULT;
	if (encoded.size > PAGE_SIZE)
		return -E2BIG;
	if (encoded.size < ENCODED_IOV_SIZE_VER0)
		return -EINVAL;
	if (!copy_from_iter_full(&encoded.size + 1,
				 min(sizeof(encoded), encoded.size) - sizeof(encoded.size),
				 &i))
                return -EFAULT;
        if (encoded.size > sizeof(encoded)) {
                // newer than what we expect
                if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
                        return -EINVAL;
        } else if (encoded.size < sizeof(encoded)) {
                // older than what we expect
                memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
        }

Or do the same reverting thing that Al did, but with copy_from_iter()
instead of copy_from_iter_full() and being careful with the copied count
(which I'm not 100% sure I got correct here):

	size_t copied = copy_from_iter(&encoded, sizeof(encoded), &i);
	if (copied < offsetofend(struct encoded_iov, size))
		return -EFAULT;
	if (encoded.size > PAGE_SIZE)
		return -E2BIG;
	if (encoded.size < ENCODED_IOV_SIZE_VER0)
		return -EINVAL;
	if (encoded.size > sizeof(encoded)) {
		if (copied < sizeof(encoded)
			return -EFAULT;
		if (!iov_iter_check_zeroes(&i, encoded.size - sizeof(encoded))
			return -EINVAL;
	} else if (encoded.size < sizeof(encoded)) {
		// older than what we expect
		if (copied < encoded.size)
			return -EFAULT;
		iov_iter_revert(&i, copied - encoded.size);
		memset((void *)&encoded + encoded.size, 0, sizeof(encoded) - encoded.size);
	}    
