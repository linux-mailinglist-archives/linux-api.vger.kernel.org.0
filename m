Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F07191A2B
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2020 20:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCXTkm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Mar 2020 15:40:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55024 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCXTkm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Mar 2020 15:40:42 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jGpPk-00063H-5B
        for linux-api@vger.kernel.org; Tue, 24 Mar 2020 19:40:40 +0000
Received: by mail-lf1-f70.google.com with SMTP id q4so6198164lff.4
        for <linux-api@vger.kernel.org>; Tue, 24 Mar 2020 12:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/2JobbXs1W8yxYMJ6+lq0xhIU5CU+OqYIQOVd5RVlA=;
        b=E1JODISxV/uXw5Tnv5/PnTwThhRddV8CKmZh+g1v0yOLsJkUPx9bD64hQ2M1IMGdUR
         kfIa6LdBYDZOylxtkn3RbaWZVpoQlQmbJfLweh+8dHAMjG5Nyn+R60D80F7SecxBQ3R3
         sQy0iWg5BEMb+teInZlgFj3920186d7OD4Yhy7rv9ltNw82ZePw66WaU2ivCTBx9V16t
         mLi2nd4V0r9NsB2fDV2qyAk2LFsBnIKZ2hHsLJZdS3ZCibXMsNxKO9XMHdr3OYaq+jq0
         onEyhvlEqT7692QSzGR1oxY/mLIlgUv6fsSswCoLimsEhJYw1JiNRZF0lmdBh9qpVBRk
         en9A==
X-Gm-Message-State: ANhLgQ0XmCb1/uniJFojmKZM3ti6lqWbf8Sa8SEXoCAFQ9hua051klfu
        OHHMXE8r/gPDWCUlSKYvUJ1nf5XpiWR6evk7sXkW3RC5I1X9gvSUBPNcG4dJ6aVLWQuTpuq3sQB
        U8rXWb+pL6P5ySxufmPCkfC4kKY+MmLdoldfdESIh4gvKIfUFpAElfg==
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr11096998ljj.218.1585078839449;
        Tue, 24 Mar 2020 12:40:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt0WbprPyjvyjWMRUlAK3041SLktIQRQSflKpi1eNe5RAyLTHHdxh7A+f14ugm+cM4/wPJn748paxHlMg1chqs=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr11096987ljj.218.1585078839248;
 Tue, 24 Mar 2020 12:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200323223035.29891-1-gpiccoli@canonical.com> <202003241137.A90B14A@keescook>
In-Reply-To: <202003241137.A90B14A@keescook>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 24 Mar 2020 16:40:02 -0300
Message-ID: <CAHD1Q_wYtuWPtDQ6xVQZ8AGbnVYhh8bYzrhnr=-OYokHEPhQZg@mail.gmail.com>
Subject: Re: [PATCH V2] panic: Add sysctl/cmdline to dump all CPUs backtraces
 on oops event
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks Kees! I'll respin a V3 without the kernel param, now that we
plan to have "soon" a way to set sysctl parameters from the
command-line.

Cheers,


Guilherme
