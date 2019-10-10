Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BDD2EBA
	for <lists+linux-api@lfdr.de>; Thu, 10 Oct 2019 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfJJQnb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 12:43:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36240 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJJQna (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 12:43:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so4266486pfr.3
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcFO8qPZ/AFTCPgcIosbPBf6WzJZhu5LC0txwMdDqq0=;
        b=mHXoFaiWr2KtDyo6AUfULISKrSL60dcxTqzjwiK6Uaub6ukWcxzvR35aRbJ/vlu4UK
         btOqmAHm7PlUoeM5gAlSvg067gi9jVrpkKoXlKtP6V0vU2ST37HIbIHFg92Bf8qEYVHH
         +sfpnRnP7n2dw4DiSrshnBTPiQgOvR4ZRzhEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcFO8qPZ/AFTCPgcIosbPBf6WzJZhu5LC0txwMdDqq0=;
        b=EV+K2sF3T0Mp25VcZHUmpGq/4bJAV/PmLeog0FZq3j0f9QDLihYwLO/yP0y3Ljl6gf
         kvPVa2He4giTzF0nwZLE9Ctgb7+FwqTSG1xcg+lCHvOuzOvH94NJxvno2DwVNfGVXaPQ
         lVDasfzFHzO8jZMY4cA6ZVtDJdA5Fuz4yytVAgeS20r0Ft47KFREQPyPhhdEXwmQjU5l
         YiyxQb2hSfQjr3J43CObXHl3paU7u/XfsrDVoPInN1e1CZPkJB4CEbVU/D2opE+Qon1+
         P5lhnBLAqsQvWuFtK7q3m3js+ZkLdbDl0VXowZ+nOvJawxJFwtgSlfK6MnFiZ31GTXPF
         Tu0w==
X-Gm-Message-State: APjAAAU6z+6KxrmF7z1gNYkkrksMT//nd53x4WAEZTGJwvR9u2D4+ZoY
        8dM0IjFYNLHw2KblYpBjpfHsyg==
X-Google-Smtp-Source: APXvYqxsqHZmX3PXU0VomobcpD35C37svv1v7Kpb0+mVbvks+MlYD9SD3jPPE8rJ5DviVJ/s9RX1pQ==
X-Received: by 2002:a62:ed01:: with SMTP id u1mr11730140pfh.122.1570725808519;
        Thu, 10 Oct 2019 09:43:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l62sm8332515pfl.167.2019.10.10.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:43:27 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:43:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <201910100943.4C6AB66@keescook>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
 <87eezkx2y7.fsf@mpe.ellerman.id.au>
 <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 10, 2019 at 10:40:07PM +1100, Aleksa Sarai wrote:
> Yeah, it takes about 5-10s on my laptop. We could switch it to just
> everything within a 4K block, but the main reason for testing with
> 2*PAGE_SIZE is to make sure that check_nonzero_user() works across page
> boundaries. Though we could only do check_nonzero_user() in the region
> of the page boundary (maybe i E (PAGE_SIZE-512,PAGE_SIZE+512]?)

Yeah, I like this idea: just poke at the specific edge-case.

-- 
Kees Cook
