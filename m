Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA63B35A9
	for <lists+linux-api@lfdr.de>; Thu, 24 Jun 2021 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFXSa7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Jun 2021 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhFXSa7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Jun 2021 14:30:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3DC061574
        for <linux-api@vger.kernel.org>; Thu, 24 Jun 2021 11:28:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so4020781pjo.3
        for <linux-api@vger.kernel.org>; Thu, 24 Jun 2021 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W4otBcBFkaGb3t72ExGbeA3urU6XFFieUgTcHqrbmJg=;
        b=RvSt49XHwLFFNeJdQhZOd8BfD5LgkCcc4r0/G7SfiJCwK1JYt3U0DmobR3Wn5toSNL
         BTc/rDTiNkbltKdMbn+BfeiYizM3fS9aWeO6aQ0Ujn/0VmIkY/2Ogim/633ZMKYj9FBA
         kyEMgYbO1NPBKS66J2xKTldaEA6+J2KPFF8FzxpdVkEVo73yTjeduBpPpcDBXMAVij/R
         NV74D1c/wEAuIq9FMNt4eMgHeYrStjtNFmSJhEcOIoDNqscmti6knnHmmRRttzXwTIyQ
         9VlcoEnH6m4jcAYlbsUdiF6xhA1WNMaTK6fpMQNXoCYToOF4xeF3fNQ1eTr3KjoBYmmv
         +jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W4otBcBFkaGb3t72ExGbeA3urU6XFFieUgTcHqrbmJg=;
        b=lMQwvNXZvZ4s40SfxKV6eZjXzXZzMJB5865JDTaFXhF3sAfIxe3s+R4yIH8IMIIu3D
         6QnGwGaJazXBJqs0UBXtCNlufpNP4ZXIDjze87kMSEkrYobydvCmvuqgJwAJVmKODeSG
         iu2hJ3yMtEHko4VnfEerc8PvqvDOseJ72m64Rz7kCsr6u3N3VN9KRoZbo+gVjumy2ADZ
         ERfopK6CxDq/Vd1/0dND/1w3YgEoNgH3vVjLmcTQb9Ge39pRpuEQScgv7IlhblTxlW+u
         w4kM03lIqP9Jw7zILRMpoWbW1HZ+d8PV3A+M9KzSqIy/289IgAD6/cU5dp49wUIj0CM/
         4G2g==
X-Gm-Message-State: AOAM533Ji4eQLPo3UP+FtjiiViwtVqE2Nioy1FXzYu3PIjniH8nQtw0q
        B6iGq85ff+tYu+W7s68QPvRq4Q==
X-Google-Smtp-Source: ABdhPJw9fgHikIFNtjlQrlkwqlshbiTWVbf+X4QEOLMTI/CytzR24wUSJE0KxBdWvgv19T90y8fzEw==
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr10818663pjb.49.1624559319238;
        Thu, 24 Jun 2021 11:28:39 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:adb8])
        by smtp.gmail.com with ESMTPSA id u24sm3700925pfm.156.2021.06.24.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:28:38 -0700 (PDT)
Date:   Thu, 24 Jun 2021 11:28:37 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
References: <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
 <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org>
 <YNQi3vgCLVs/ExiK@relinquished.localdomain>
 <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 24, 2021 at 10:52:17AM -0700, Linus Torvalds wrote:
> On Wed, Jun 23, 2021 at 11:15 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > On Thu, Jun 24, 2021 at 03:00:39AM +0100, Matthew Wilcox wrote:
> > >
> > > Does that work for O_DIRECT and the required 512-byte alignment?
> >
> > I suppose the kernel could pad the encoded_iov structure with zeroes to
> > the next sector boundary, since zeroes are effectively noops for
> > encoded_iov.
> 
> Ugh.
> 
> I really think the whole "embed the control structure in the stream"
> is wrong. The alignment issue is just another sign of that.
> 
> Separating it out is the right thing to do. At least the "first iov
> entry" thing did separate the control structure from the actual data.
> I detest the whole "embed the two together".

I'll suggest the fixed-size struct encoded_iov again, then. If we're
willing to give up some of the flexibility of a variable size, then
userspace can always put the fixed-size structure in its own iovec or
include it inline with the data, depending on what's more convenient and
whether it's using O_DIRECT. A fixed size is much easier for both the
kernel and userspace to deal with. Do we really need to support
unlimited extensions to encoded_iov, or can we stick 32-64 bytes of
reserved space at the end of the structure and call it a day?
