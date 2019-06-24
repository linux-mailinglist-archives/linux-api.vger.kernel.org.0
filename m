Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9777C50C54
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfFXNtZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 09:49:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34743 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfFXNtZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 09:49:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so14030047wrl.1
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rsdGK2qnX79rTvs0ljNXRm1xbFRSbM8T7vFuJMDh/e4=;
        b=Y2tiIQZwBrjoPLeq3Rv0KfJCpIb+su9vtzZU4xXl4jeBRjs2aSiX0vpl3DmBFrc3XA
         AAN3mK5Ju8rd5DhZr3DDBqGcchmQlUXxeGY3ypb5EZKknZkeUUjLWVqcd5Z1RM6FtIcy
         8fyFEJlJW2dw+FbWJgoYfPl5XGmJxeXo1eUjRLeQbu5zidjUgCKL2flBaZ3rr26LNBhE
         nS8jzzI1f5+kwATJP9w96MmBHywPO8qfWk9CZ8RE+xHUctiLnZ/n+KbxQZx1Sl8LRVFN
         Ou39dJirN1zI71ePA2LcSxCxo6jHY0j++wiDDkOQaunwXkelmFvCY04HdJTNAvcEuJVr
         8j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rsdGK2qnX79rTvs0ljNXRm1xbFRSbM8T7vFuJMDh/e4=;
        b=HasyNSNBYGPVRaj0LFhuwaPvIInUzY+eu+wmVpElY02eoqtoilYJJNJIawqcybJ1pJ
         jFcoUxA9DGiNUjYVL4DjPss7i42wynHczhKCOnBriqTCbvYYU+iNGmp6vNBXcWqJcWtU
         fdXEBqL9xS3LvbYkIFgq3UDVnEY9/YphS8BTFnpSy6JhRUq8512ttYqz4gOyfBeklg7c
         At2LfCFQ6amHWqJov06hdYZ2oJUqvZkDfTggH3igz77P07DmqGvg8q+eWaJS9vQ9KsaR
         AlAZ7ZXYhQsOtzvpA6HHlrVC5thAuuaqTq+KItqxi0LIYlfQ5jGA0VLGILR6y+0vlnZx
         7zrg==
X-Gm-Message-State: APjAAAVOuGYOwn5xC8HG5aRs3Wnpd3Qo4GRpwWU45juaa1iGnlM08JAU
        Ls/vjJOFLCHCPrqocgNPjnwEfoEr4Bc42g==
X-Google-Smtp-Source: APXvYqxuquNMvAAfZG4V+M7gpFHzpGXJ5ZSbCV/2x8yFdbcJooCiejxG1/KTzrKxWTetVLKjvMmGgg==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr98450455wrw.138.1561384163510;
        Mon, 24 Jun 2019 06:49:23 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s8sm13760952wra.55.2019.06.24.06.49.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 06:49:22 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:49:22 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] CLONE_PIDFD: do not use the value pointed by
 parent_tidptr
Message-ID: <20190624134921.mvgabuz3mgmpuu3n@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623112717.GA20697@altlinux.org>
 <20190624094940.24qrteybbcp25wq7@brauner.io>
 <20190624115942.g6vyis3zy4ptt3fc@brauner.io>
 <20190624134531.GB6010@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624134531.GB6010@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 24, 2019 at 04:45:31PM +0300, Dmitry V. Levin wrote:
> On Mon, Jun 24, 2019 at 01:59:43PM +0200, Christian Brauner wrote:
> > On Mon, Jun 24, 2019 at 11:49:40AM +0200, Christian Brauner wrote:
> > > On Sun, Jun 23, 2019 at 02:27:17PM +0300, Dmitry V. Levin wrote:
> > > > Userspace needs a cheap and reliable way to tell whether CLONE_PIDFD
> > > > is supported by the kernel or not.
> > > > 
> > > > While older kernels without CLONE_PIDFD support just leave unchanged
> > > > the value pointed by parent_tidptr, current implementation fails with
> > > > EINVAL if that value is non-zero.
> > > > 
> > > > If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd == 0
> > > > pointed by parent_tidptr also remains unchanged, which effectively
> > > > means that userspace must either check CLONE_PIDFD support beforehand
> > > > or ensure that fd 0 is not closed when invoking CLONE_PIDFD.
> > > > 
> > > > The check for pidfd == 0 was introduced during v5.2 release cycle
> > > > by commit b3e583825266 ("clone: add CLONE_PIDFD") to ensure that
> > > > CLONE_PIDFD could be potentially extended by passing in flags through
> > > > the return argument.
> > > > 
> > > > However, that extension would look horrendous, and with introduction of
> > > > clone3 syscall in v5.3 there is no need to extend legacy clone syscall
> > > > this way.
> > > > 
> > > > So remove the pidfd == 0 check.  Userspace that needs to be portable
> > > > to kernels without CLONE_PIDFD support is advised to initialize pidfd
> > > > with -1 and check the pidfd value returned by CLONE_PIDFD.
> > > > 
> > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > 
> > > Reviewed-by: Christian Brauner <christian@brauner.io>
> > > 
> > > Thank you Dmitry, queueing this up for rc7.
> > 
> > This is now sitting in
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=43754d05f235dd1b6c7f8ab9f42007770d721f10
> > 
> > I reformulated the commit message a bit and gave it a Fixes tag. Dmitry,
> > if you want you can take a look and tell me if that's acceptable to you.
> 
> s/Old kernel that only support/Old kernels that only support/

Fixed.

Thanks!
Christian
