Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3368F50A48
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfFXL7r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 07:59:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33960 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFXL7r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 07:59:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so14093777wmd.1
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NISf2AF+teimA9xsNpoKX9LvLTU//qt9iSbtSvGhumw=;
        b=O33JM0SQsoxgxG2UxDCzjJt5FATg92mACnzbJMOJ77sZn/u3/ZkeQMZe+44zyPFGFy
         azEIg/a/j6bQ62w12aW1UhqEjbzphb6ucFWHtE/9KOXYAA/QBPc92y9/CFLB2p7VYxyE
         KN/Lig39fYFeU5wlSB7JhOX/1StAcz9efFdJ1B/fOz0uU6k/ViJIuhFhgqYO9aDDDu1o
         SWdMhVNBoh0scdsdFhZeX6GY31qP6jfT3DuVZeCd7OWql8DZJ4wBi8zTcHRjEhIATAWy
         PxNsFyyX06R3vxUWF1CMot/Wi3UsysFBxit5k/umwYwAs8spQsp1WxgIZBkw3MD4Ybt7
         iUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NISf2AF+teimA9xsNpoKX9LvLTU//qt9iSbtSvGhumw=;
        b=Q9syoIHApJrbGYhonVifqXFTPuXVMsP02+BLk/a7xZkfACjpchD/+DmiIKneWQCiGd
         QaBLSjZEs6VGsIq283Dxn/6oIOJdOZtZN3zIkIYEHKUT6cY8PLCS2wLCgduNXXvU0hvi
         5PCaI68HijOiPX5cHQtDv04B9haArCputbzmVJHs8Pr8Cg4zOjJrGQJ8v3EpmdUPE6/Z
         7rJ/b3OehIBdXwVTwHIe4K3RzF3Zlv2mVLFMmlwx6p8Gx3fKmnJf4ERFUrb2mu4xoxxk
         PbD+whb6VHrt369XZQNkNlOTQ/y3UxmuRyHAclk5qyE7C1Acv/oPH98tVasimU0wyBCi
         wX9w==
X-Gm-Message-State: APjAAAUtW+4EK4U4Z89rgEX7DbJudKVVok3AUsLg1BN7vvOXZDbikpyP
        r6AXdp9oHCtUvItIxZqQ3xM9qw==
X-Google-Smtp-Source: APXvYqzbvN//jhpLvthmB++J02P6cMJxBojLpsBGnGF5magVaxEUPJO2AWmZrViBtMYJg98kV8Cg3w==
X-Received: by 2002:a1c:a6d3:: with SMTP id p202mr16445912wme.26.1561377584822;
        Mon, 24 Jun 2019 04:59:44 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id l1sm32113168wrf.46.2019.06.24.04.59.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 04:59:44 -0700 (PDT)
Date:   Mon, 24 Jun 2019 13:59:43 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] CLONE_PIDFD: do not use the value pointed by
 parent_tidptr
Message-ID: <20190624115942.g6vyis3zy4ptt3fc@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623112717.GA20697@altlinux.org>
 <20190624094940.24qrteybbcp25wq7@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624094940.24qrteybbcp25wq7@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 24, 2019 at 11:49:40AM +0200, Christian Brauner wrote:
> On Sun, Jun 23, 2019 at 02:27:17PM +0300, Dmitry V. Levin wrote:
> > Userspace needs a cheap and reliable way to tell whether CLONE_PIDFD
> > is supported by the kernel or not.
> > 
> > While older kernels without CLONE_PIDFD support just leave unchanged
> > the value pointed by parent_tidptr, current implementation fails with
> > EINVAL if that value is non-zero.
> > 
> > If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd == 0
> > pointed by parent_tidptr also remains unchanged, which effectively
> > means that userspace must either check CLONE_PIDFD support beforehand
> > or ensure that fd 0 is not closed when invoking CLONE_PIDFD.
> > 
> > The check for pidfd == 0 was introduced during v5.2 release cycle
> > by commit b3e583825266 ("clone: add CLONE_PIDFD") to ensure that
> > CLONE_PIDFD could be potentially extended by passing in flags through
> > the return argument.
> > 
> > However, that extension would look horrendous, and with introduction of
> > clone3 syscall in v5.3 there is no need to extend legacy clone syscall
> > this way.
> > 
> > So remove the pidfd == 0 check.  Userspace that needs to be portable
> > to kernels without CLONE_PIDFD support is advised to initialize pidfd
> > with -1 and check the pidfd value returned by CLONE_PIDFD.
> > 
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> 
> Reviewed-by: Christian Brauner <christian@brauner.io>
> 
> Thank you Dmitry, queueing this up for rc7.

This is now sitting in

https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=43754d05f235dd1b6c7f8ab9f42007770d721f10

I reformulated the commit message a bit and gave it a Fixes tag. Dmitry,
if you want you can take a look and tell me if that's acceptable to you.

Thanks!
Christian
