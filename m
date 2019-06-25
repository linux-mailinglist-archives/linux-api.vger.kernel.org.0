Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C045F55867
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFYUIK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Jun 2019 16:08:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44153 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFYUIJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Jun 2019 16:08:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so10027406pfe.11
        for <linux-api@vger.kernel.org>; Tue, 25 Jun 2019 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTBYIsHI8zTMLEyvwtX6vz4jgxzEbNHxNVg1zzv+uWs=;
        b=GFD4YL7rkGte7dY9QecMGQVpBAuunM7M4kNB4I4J4HToFkTT6kzO4mzdswjpF7r040
         S9GAX102W+LhmXZ4yS3Q53lWrLv0qMrY09Rn9OEGQf3DWq6oOD93s6yEIZi9ZSY/8mOE
         tHZM21Pp0ucGbM3ZzgASmEvwhutvcH3mQAzmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTBYIsHI8zTMLEyvwtX6vz4jgxzEbNHxNVg1zzv+uWs=;
        b=NR+xMqN8aPLsZJ9iDmh9ZpuP6vtFseoxSCAW+KcZYbbtqYdL8xBl2JtdSujXX7trTc
         HZZa3i77ne++J0+7xgJQjLuh/9DnKYld5+PZpxDK4XBrwotKn7DCh0ZT50j8jn4BMNqi
         eTGTfA7fw91EPY3xkNPP10Lm5G9APyx1QCaEb4R7/F6CRCL9LzCMLjpdPAU86+L1NHFM
         arewjOeg66fnA1DbRiJvDm5azZ5gwn9fmdp8gGSuDYJMd8h5JVaUe4q5v+EYkLwDJO/6
         JtWaALIrz0Jz4MGCm2mlF+ifedWcIkwfOEZxwRn5jweWpss6Ezi0LKHeeGh88CSAMH3I
         uVhg==
X-Gm-Message-State: APjAAAX2R6tPcRCXFa0DYZbIMJ+qKRmQ5hoV6K9MIeEBai9iqBk+g6Xr
        4umNPawMUVf0gNQ4APWzJw9lAA==
X-Google-Smtp-Source: APXvYqz4wFwSx2u/z3fzZResgKJfp4GOCsNFxJX8Qh/tN021DReuR4LVm+X37zl/gnxfdS1yHAMYkA==
X-Received: by 2002:a65:62cb:: with SMTP id m11mr25236218pgv.27.1561493289120;
        Tue, 25 Jun 2019 13:08:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm4271354pgg.86.2019.06.25.13.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 13:08:08 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:08:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: Detecting the availability of VSYSCALL
Message-ID: <201906251131.419D8ACB@keescook>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 25, 2019 at 05:15:27PM +0200, Florian Weimer wrote:
> Should we try mapping something at the magic address (without MAP_FIXED)
> and see if we get back a different address?  Something in the auxiliary
> vector would work for us, too, but nothing seems to exists there
> unfortunately.

It seems like mmap() won't even work because it's in the high memory
area. I can't map something a page under the vsyscall page either, so I
can't distinguish it with mmap, mprotect, madvise, or msync. :(

-- 
Kees Cook
