Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EA372E19
	for <lists+linux-api@lfdr.de>; Tue,  4 May 2021 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhEDQbe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 May 2021 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhEDQbe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 May 2021 12:31:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F93C061761
        for <linux-api@vger.kernel.org>; Tue,  4 May 2021 09:30:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so14149460ejj.3
        for <linux-api@vger.kernel.org>; Tue, 04 May 2021 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ctdlXSgA9WB8/LgWtL0CJavRE/GrXThnOTOG0Yn+j2M=;
        b=PV7H9lwE2fkMD9FY3zZI2IQ1LJUNNJi+MErHVDmQXkw7CP2xrU/TYHlHczAfDm5lVa
         KDiLaKQ00UK/IHHZuLCrQoUb6nNF2np0jdBgPOKnW02lTxjNCfGGcqjbWs0FnUqtA2bw
         4MCLLKv0oasjlveEwIDLg7pD/6kl+SgNCQ9ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ctdlXSgA9WB8/LgWtL0CJavRE/GrXThnOTOG0Yn+j2M=;
        b=pkxydOxhSsJ4bkEnybj3/T+t7gvtbQKaHy6bQ+MIhDet+yJnJLHPdwoW92RceVOdnN
         s/93Xr1yWxsAaP3t6v2jBIORKvdjukDXKIovvPAGGDKkCs93qDUdMqe+AlHnH6sjniDs
         h4zbcIfXrXtDKoIvdTV54Jv0yFfnFebTJEXiuxDD0p9XK60Y1wzugh7pbPWx3nUJXsI0
         QIyCwNTayTpd6hEWUYgd1iY3u05czKf1P+wOpKJzTkLQVgWNYrO549YZjGf2Llyo8QeB
         g5x17ZaVLBjfSVRBuSHV8DNeo9rmHCwEbebXjgbACW7ulHxBD/bPk2xWKjICPEyly11T
         3aOg==
X-Gm-Message-State: AOAM532ik3MHFmc7u3xQ22jrhzZ7mVk5d23Rfk/U0QwIxQFxeq+vD2+h
        Ngkd0V/xEJvFPB7BvX7oaahUgw==
X-Google-Smtp-Source: ABdhPJxnDxkwXkTAVEK/PThX9uS74sv8umtjiWwfjWMmVibtFA3GJeFZ5aOd5+yEYTEA4wsXOVzSiw==
X-Received: by 2002:a17:906:d145:: with SMTP id br5mr22140782ejb.452.1620145837348;
        Tue, 04 May 2021 09:30:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id kt21sm1615904ejb.5.2021.05.04.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:30:36 -0700 (PDT)
Date:   Tue, 4 May 2021 18:30:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg Kurz <groug@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Paul Mackerras <paulus@samba.org>, linux-api@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org
Subject: Re: remove the nvlink2 pci_vfio subdriver v2
Message-ID: <YJF2qm+voakTWq9M@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kurz <groug@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20210326061311.1497642-1-hch@lst.de>
 <20210504142236.76994047@bahia.lan>
 <YJFFG1tSP0dUCxcX@kroah.com>
 <20210504152034.18e41ec3@bahia.lan>
 <YJFY7NjEBtCSlJHw@phenom.ffwll.local>
 <20210504155327.GA94750@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504155327.GA94750@nvidia.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 04, 2021 at 12:53:27PM -0300, Jason Gunthorpe wrote:
> On Tue, May 04, 2021 at 04:23:40PM +0200, Daniel Vetter wrote:
> 
> > Just my 2cents from drm (where we deprecate old gunk uapi quite often):
> > Imo it's best to keep the uapi headers as-is, but exchange the
> > documentation with a big "this is removed, never use again" warning:
> 
> We in RDMA have been doing the opposite, the uapi headers are supposed
> to reflect the current kernel. This helps make the kernel
> understandable.
> 
> When userspace needs backwards compat to ABI that the current kernel
> doesn't support then userspace has distinct copies of that information
> in some compat location. It has happened a few times over the last 15
> years.
> 
> We keep full copies of the current kernel headers in the userspace
> source tree, when the kernel headers change in a compile incompatible
> way we fix everything while updating to the new kernel headers.

Yeah we do the same since forever (it's either from libdrm package, or
directly in the corresponding userspace header). So largely include/uapi
is for documentation

> > - it's good to know which uapi numbers (like parameter extensions or
> >   whatever they are in this case) are defacto reserved, because there are
> >   binaries (qemu in this) that have code acting on them out there.
> 
> Numbers and things get marked reserved or the like
> 
> > Anyway feel free to ignore since this might be different than drivers/gpu.
> 
> AFAIK drives/gpu has a lot wider userspace, rdma manages this OK
> because we only have one library package that provides the user/kernel
> interface.

But since we have some many projects we've started asking all the userspace
projects to directly take the kernel ones (after the make step to filter
them) so that there's only one source of truth. And also to make sure they
don't merge stuff before the kernel side is reviewed&landed. Which also
means we can't ditch anything userspace might still need on older trees
and stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
