Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6641D0170
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 00:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgELWAW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 May 2020 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731341AbgELWAV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 May 2020 18:00:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC50C05BD09
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 15:00:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so5988655plr.3
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+79i6CNjIBAM9t+ay0r61vFhVwB4nVo6+b6hHSQ4Fro=;
        b=Z/kjEVE7ijoWI2BF5GmEwAS2TVMlcwmQ3piX8x8xKGksNXYU58li/dNrs7QXxUoz7v
         WcPUKAYo4D+A3Vjcp2GxS4KQ9NMekKqFlUGG2RHxbDNQhoqZoY/xpwrNADyPpkJA3XMs
         ldEER+nN+tYegKNCyBNg4B35WbSpqTnd27sU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+79i6CNjIBAM9t+ay0r61vFhVwB4nVo6+b6hHSQ4Fro=;
        b=SlGMnWKS8hKmlh6UphIrZM2n8i7+CtG1131LyQi501RiudlHIC8AOBXud6fdCuyTG6
         +Z38sKm7JOvJzg17lBSc+EFUJfnY6gBhw8kevy1vb7KuZI08Iy9m6zUvQjfRNJnbJUGC
         a5mRXh3f8EPkd0NhlmVJzPdiEth83sXWBku6jSWtljQzkEl+cM0cO5uT2m/9+kOh8SpD
         h6Jd6LQs1oeUoS27C+1R3/mbZpJr5SIEPxEMPC5ierWwC6xrc4PWJDvR2Vu3lHt0zvu1
         AkImj68C3Hrk11hYejLieW6lmWpaTzeRQ/44E0DJWRaQ27a5hyAx6+gTCUAB17Tf5D9G
         hJFQ==
X-Gm-Message-State: AGi0Puairkq8gNR3UYPzM6Aj0WBp3xKULrjMNQi8HijRRJV+Ll6Sm/HK
        cS5UdPEbazd3w2+bSO90AhFOrg==
X-Google-Smtp-Source: APiQypKLh7L5M6Z91bm0o0e2Xo3kz9JFIjZHGl9tokP3YDbmJ9kq2VCMFUVZ8H/2dEcftnriFb6DmQ==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr31509425pjs.127.1589320820943;
        Tue, 12 May 2020 15:00:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2sm13193542pfb.73.2020.05.12.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:00:20 -0700 (PDT)
Date:   Tue, 12 May 2020 15:00:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] doc: Add documentation for the
 fs.open_mayexec_enforce sysctl
Message-ID: <202005121459.158C3AE75@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-6-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505153156.925111-6-mic@digikod.net>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 05, 2020 at 05:31:55PM +0200, Micka�l Sala�n wrote:
> This sysctl enables to propagate executable permission to userspace
> thanks to the O_MAYEXEC flag.
> 
> Signed-off-by: Micka�l Sala�n <mic@digikod.net>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>

I think this should be folded into the patch that adds the sysctl.

-- 
Kees Cook
