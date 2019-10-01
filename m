Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F380FC3A7B
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbfJAQ2w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Oct 2019 12:28:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35415 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389921AbfJAQ2w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Oct 2019 12:28:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so8382130pfw.2
        for <linux-api@vger.kernel.org>; Tue, 01 Oct 2019 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i0vYOnNzNl23wM5oAHQgXQknCy7kFcbZ26kS9YCoHBU=;
        b=n5fjg1bqcekd+hNTKhsmR269yN2JoDYT7RNHZANM0CG3KvJR4l0sKewNwj5Cl+7/R4
         lAyx5LnFBIt1px6L05UmEZPA9i2zOAJkpjn/cjD7aaFAwAdjVxTREahP7BB/PM3xPtIp
         zjjyDFWC3J3WfPK3n+0rHoaP3GdV6ByAiWF14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0vYOnNzNl23wM5oAHQgXQknCy7kFcbZ26kS9YCoHBU=;
        b=FRM6hR3Pe0Ew+E3dPxbQ+5zcjvcuDI9hNDM0e/pZehGLAMu1fIBG8v2NohJZlMQa3G
         OGWr7PPCTCoAIcmfwElmTr9IIWk1IUHItWkPV5vi6EXgheyrwsIwTDzcoLl/TOcRxbZV
         N/+faw03cUHNxV6Sa3VgR+nUn8PaWBn4YykOee5vcLQEJkSLe70KwdeTcLz6ruVFlc29
         E4VWXUYHERyI1g1lkB4hE151W6nvdY0nenEyzOXUH5qW0Fw+zeCvrsjjpFG+wrzwZazl
         9UP9wnd7amRvnb47P5e97b56lNY3U315k7fvCAyYj4dOX/1Q016sqIN8TAgz6OfD46ul
         1YoA==
X-Gm-Message-State: APjAAAUJcqE0+nPMWehZBe6Z9f1HTPtgzis1J3F5VU4/zTi5oBsjTxPi
        AaXczT+OFbxJUpYtCpLMYZt0NHN/k+Q=
X-Google-Smtp-Source: APXvYqxsBvaB4PwyrQX1efSVDTYBbjVuirkKmUqj8X/jNHPZhagjzfCPkrTmQzSXjn9MZFUDVhtoTQ==
X-Received: by 2002:a63:cb:: with SMTP id 194mr30303545pga.172.1569947330613;
        Tue, 01 Oct 2019 09:28:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm26975081pfq.20.2019.10.01.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:28:49 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:28:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <201910010928.243849D@keescook>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
 <201909301856.01255535BD@keescook>
 <20191001023126.qhzeiwmtoo4agy7t@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001023126.qhzeiwmtoo4agy7t@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 04:31:27AM +0200, Christian Brauner wrote:
> On Mon, Sep 30, 2019 at 06:58:39PM -0700, Kees Cook wrote:
> > On Tue, Oct 01, 2019 at 11:10:52AM +1000, Aleksa Sarai wrote:
> > > +static __always_inline
> > > +int copy_struct_from_user(void *dst, size_t ksize,
> > > +			  const void __user *src, size_t usize)
> > 
> > And of course I forgot to realize both this and check_zeroed_user()
> > should also have the __must_check attribute. Sorry for forgetting that
> > earlier!
> 
> Just said to Aleksa that I'll just fix this up when I apply so he
> doesn't have to resend. You ok with this, Kees?

Yup; that's totally fine. Thanks!

-- 
Kees Cook
