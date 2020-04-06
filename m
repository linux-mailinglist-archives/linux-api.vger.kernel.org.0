Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13419F95E
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgDFPzb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 11:55:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36847 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgDFPzb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 11:55:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so6080640plo.3
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSjkzhFEiFJjyufT8+HraUsb7czl0gNB79kUOtKiYko=;
        b=UBwbD9Fh2afx2lBbBBT4XMur9J9n4jUPu1rc4OUDGxMx+Ajc2wvGaAdQnMQlBkzsnr
         +8h6sXlemiz/8/52IJN8D40WBcKL/y010DcYxll1huL1G53cvuCJrvKJKdU1bhRZN5nY
         mW08EAE7q6lAjTkd4M3LAdvYDNmIr4f3nSivA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSjkzhFEiFJjyufT8+HraUsb7czl0gNB79kUOtKiYko=;
        b=s3nMv4VSFh2fNxhymHFWRNlEZENNZOEAcSaqYFV9qd96nj6ICdnfNMcyz8Qvtp6MIL
         pmfWtrGjeYDJArnsBf0CS1wdIRFIyygpiunZaZDe+P4uIZ2HV9uOpeR/sNA1o5sGLBg9
         p8itKCj+bl5vweZ+tbmHonWRq0tV50HezgHEqhM4EcDTM+ucPAj10dcpdflje8FFjGZH
         9vxEA8OI1CTKiZZ5Lfrx4SO9xMc1umXs1Kkg1wAEOtF8LJIZYrKw0jmhzPF2jOytQpzF
         iE6hxfrpe0ODOmUOS9FZO38bkhKApildVZUYW+aKfI08ixWGPW28W91JTdZOyQNTUIZp
         qAZQ==
X-Gm-Message-State: AGi0PubKdYYOiuh85A4kLuqeZ3pW390yNSfz6NRRJaLH1wo9u90Y4ige
        25apoQWZNdmNiIQGNoW/3CcUHg==
X-Google-Smtp-Source: APiQypJq6G4sfj4F480buN+2USewCEdxsSs+iaxAsio9clFT3schIx04v6ekH8nGfBzDTwyT28JlCQ==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr20706329plt.111.1586188529962;
        Mon, 06 Apr 2020 08:55:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm14581pjf.26.2020.04.06.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:55:29 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:55:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, penguin-kernel@I-love.SAKURA.ne.jp,
        vbabka@suse.cz, rdunlap@infradead.org, willy@infradead.org,
        kernel@gpiccoli.net, dvyukov@google.com
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
Message-ID: <202004060854.22F15BDBF1@keescook>
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 06, 2020 at 09:28:41AM -0300, Guilherme G. Piccoli wrote:
> Hi Andrew / Kees, sorry for the ping.
> Is there anything else missing in this patch? What are the necessary
> steps to get it merged?

I'm expecting Andrew to pick it up, but it's the middle of the merge
window right now, so there is likely to be a couple weeks delay before
this will appear in -mm.

-- 
Kees Cook
