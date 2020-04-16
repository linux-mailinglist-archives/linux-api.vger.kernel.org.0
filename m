Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85E1ACE3D
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDPRCJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729816AbgDPRCI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 13:02:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A9C061A0F
        for <linux-api@vger.kernel.org>; Thu, 16 Apr 2020 10:02:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id ay1so1573011plb.0
        for <linux-api@vger.kernel.org>; Thu, 16 Apr 2020 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jM5h1KFj1L2GXPRZjBV7ijyxLB4BFuJ/vu3Z2ACwOH0=;
        b=upWStF2+6JIY7WIbqEKUk+gI5CQolvn8tp2lCpTiFpSeX1L+TPFq7VBfGYfr/PXbms
         /SQYrkACqUfYns0cjwtSFepEft+7s8M4jbd0T/kRWAttVqMMZTeiu2tsEPGtfm+wDcbH
         LbBB4elRVgQ8QIp3a3juih4HZQ+slHWHTNXyacHtbxZx8ciSGDx0ImYltQj3C8m0wGAk
         IpPgkdpA5pUJy09YKtzkSFGj6V9YDm6TI096DZ6AyzdOdR2+BJVpIEuyTXXkA8uTk71S
         NYQFj1eoQqvqBlNu8qs9Kk1wCFxX2DyP/0Tt7MbdSHeRwkmx5COOYiT17fRc+2QOGpFV
         qNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jM5h1KFj1L2GXPRZjBV7ijyxLB4BFuJ/vu3Z2ACwOH0=;
        b=gAnJmQX3Hw0X0gbxOOoqiLO912KJiknN50azp9Cn2rqLSrQSJpCvKGVaXbij03rzW3
         CPeAx43zRNpWPqAzRt9bl3F8k8ADReqxHxb0d52FMSG26KHHtImC/BKJn0jqwb/jmjW1
         MjgNPeOK2HdXv9MrS+LJ3+H5R43xv52ZYZI5gJYsQ1AlGxezPBTqpfLsKQsWwEYSMEeq
         t0AIPlBuVKnY1uGY4ybITCH1B6Gr7jDd/5KYMTdRA0Ai1q+ALtAifDPNwthQu5opVw1A
         5vkXv15xmvMEUokGYukglDZ8vIlHgBs94FM5hi7k85mobtNXs9toX2QgT/bkwod1DQRo
         r+Mg==
X-Gm-Message-State: AGi0PubWcs5WhdbUvw69vDlyLobVSa7PEoGJGSBRzaWTazP++uZZXrWY
        k3DoKYMj7gQ5Pfs2AWZ8TzuNyQ==
X-Google-Smtp-Source: APiQypJqg0pOISaJvxNLbk+rEYy/BAV/B+cdSZie5ezyzvBXT70vsoZhCw53vIeIUdY5Sj/wNtfkhA==
X-Received: by 2002:a17:90a:af8c:: with SMTP id w12mr6153045pjq.37.1587056525879;
        Thu, 16 Apr 2020 10:02:05 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::7584])
        by smtp.gmail.com with ESMTPSA id y186sm4958753pfy.208.2020.04.16.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:02:05 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:02:03 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux btrfs Developers List <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v4] Document encoded I/O
Message-ID: <20200416170203.GA696015@vader>
References: <cover.1582930832.git.osandov@fb.com>
 <00f86ed7c25418599e6067cb1dfb186c90ce7bf3.1582931488.git.osandov@fb.com>
 <CAKgNAkhpET_oK8SKoJhmo1LWk2n0pUXQ-+LfA6=V1cBK485RWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhpET_oK8SKoJhmo1LWk2n0pUXQ-+LfA6=V1cBK485RWw@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 16, 2020 at 02:26:01PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Omar,
> 
> (Unless you CC both me and mtk.manpages@gmail.com, it's easily
> possible that I will miss your man-pages patches.)

That's good to know, thanks. Do you mind being CCd on man-pages for
features that haven't been finalized yet?

> What's the status here? I presume the features documented here are not
> yet merged, right? Is the aim still to have them merged in the future?

They're not yet merged but I'm still working on having them merged. I'm
still waiting for VFS review.

Thanks!
