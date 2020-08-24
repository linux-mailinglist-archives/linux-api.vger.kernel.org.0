Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0670B250A91
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 23:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHXVLV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 17:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgHXVLT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 17:11:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12164C0613ED
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 14:11:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i10so5258700pgk.1
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dSxggIWYJnAj641M9XzShpvsdRzxcqklORI4hC1bcZg=;
        b=i6iAMiwPrOKxVhhyDgghkvBK9TwV37/kNIOC4qlpoB/S8v4AIsxbqKamVLeWF2dlDL
         BLdRVqC16KYABOcDzUY0WK5emHjIHJujKi4nQlt5P8Rt2SuDhcTJmSFZJK4xuncFRo05
         POO+2SUBU36E7UIhSLSGLInhl8Ud9ashg/i5HDOjjRap+JlXHD9OQNgphN8VxdQqM+o6
         wAlEG6xX+0JM9Agr+Z8VpEEJ+Z2bqr9uvTJSmXWcETwZAc0AggPgFFScJHsyFMMgoqEm
         g4PNeaJrOVL5DhmorOywOsmHKw60An45LSCT1MdMqipWiqmuuoHw9EWglQsDFK3/sB7y
         S/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSxggIWYJnAj641M9XzShpvsdRzxcqklORI4hC1bcZg=;
        b=dlLT3rgwuIsSH/ZQ2uWYBVi+RCPE9SgZj5qEEtLBKT8SXhPGWeBIzfkyZjlZXmRlaO
         cvvVGWTnQzqeskcEDwn54b/6olbJ90e0r+noPOc9W4wxzuApiGRQRTKDFu37ck+M0YI9
         xL46otSef/I+oX/+3ex7aw2EWH8rIre4Y32un/qdiIQKJ1E2WuNTIKr6gqDdUvXYn9W7
         xlvNbnR6evyj4c9jVesPt21A6QOs9JYUdzYN33mA1s+TeZdNoTeH52oV61kBIEoONONa
         G4bjY8YgJ8icTLgyf0g4WXhHUjUV7cX6ODn6/1fhyq11c+ESg7nhHdxt8j0Gt2kfMbOO
         tYfg==
X-Gm-Message-State: AOAM530LudnxvoKO9m6nptg0LXFEoWfg1iNNd1OzeIoORyQV3lvP9Yb0
        lMLnDUsvJec3+mk/03dCi9Y8eg==
X-Google-Smtp-Source: ABdhPJypFjd84ljN3wDRQmnbFvf1otGCfCVscA2ErlmfqM+U8CwukKDeMXqwq/W9hVIZBoRnIEVYIw==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr4977097pls.286.1598303478248;
        Mon, 24 Aug 2020 14:11:18 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:8d5d])
        by smtp.gmail.com with ESMTPSA id t63sm10560733pgt.50.2020.08.24.14.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:11:17 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:11:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 2/9] fs: add O_ALLOW_ENCODED open flag
Message-ID: <20200824211115.GB197795@exodia.localdomain>
References: <cover.1597993855.git.osandov@osandov.com>
 <f0db9f271dbe563d2ceaae68f8b74ce4b424efe5.1597993855.git.osandov@osandov.com>
 <3c44cdf2-e0fd-cea1-4028-d6315ba3b7fd@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c44cdf2-e0fd-cea1-4028-d6315ba3b7fd@toxicpanda.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 24, 2020 at 02:28:39PM -0400, Josef Bacik wrote:
> On 8/21/20 3:38 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The upcoming RWF_ENCODED operation introduces some security concerns:
> > 
> > 1. Compressed writes will pass arbitrary data to decompression
> >     algorithms in the kernel.
> > 2. Compressed reads can leak truncated/hole punched data.
> > 
> > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > possible to do the permissions checks at the time of the read or write
> > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > fcntl(). The flag is not cleared in any way on fork or exec; it should
> > probably be used with O_CLOEXEC in most cases.
> > 
> > Note that the usual issue that unknown open flags are ignored doesn't
> > really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> > O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
> 
> It seemed like you agreed to require O_CLOEXEC to be set when using
> O_ALLOW_ENCODED in your last go around, what happened to that?  I know I'd
> feel better if we had that requirement, and if we aren't I'd like to know
> why we can't.  Thanks,
> 
> Josef

Yup I was still on the fence about it since it's a bit of an awkward
requirement, but I'm convinced now that we might as well be safe and
require it.
