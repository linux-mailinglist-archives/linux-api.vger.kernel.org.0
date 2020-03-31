Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91D5198D5B
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgCaHsl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 03:48:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34705 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgCaHsk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 03:48:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so24651101wrl.1;
        Tue, 31 Mar 2020 00:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDDR7wkznk3Ln/XEBAe1hdquHTqCjRL2OUXoeHhs1/I=;
        b=Z77vJpOfp8yhqPr3LNrlEZ9xKS88nkKs0ooW6hoj05vg2n5TBZrhoIJc6MR9Qz6oFH
         P/rHVEPKV283YxVZUuFHuP5A3RI7AE7BuZMoHuGEsuDxxsMlb+1YTRZku1x2n66hNtK8
         GbSaii1CDz4NLElt2y20/ymcp4tCuT9lTh9FXPqoerF9aBEk2D4Qvt84FdtaFxJ1smc+
         GQdzeKQcE1pAwFiPu/qfRRQpyjBmG12jgmIV7g1FeZbuaKecBuybnlfli8rXpJE4uUoI
         GZCwhrxyfNMgSh8kHQLJlRkLShUHKuNZQnh6/aQmgnq/ER3uT88UQqNPL9hMwjfL4qwG
         3ycw==
X-Gm-Message-State: ANhLgQ3E/2s5bN11iMI0GGDJ83oCOg+8mJxX5pBOTgPPFXPxTujyi45K
        Jb5NEvrOA7r846EVzJzkJAA=
X-Google-Smtp-Source: ADFU+vv3EXliVsMAUSV9EjxsWTfTwAunV64IBIwQFULkiEChbiWPpqyxtb84adDetxoemQODGsJkDA==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr6877457wrm.65.1585640919502;
        Tue, 31 Mar 2020 00:48:39 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id t81sm2728726wmb.15.2020.03.31.00.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 00:48:37 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:48:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200331074836.GB30449@dhcp22.suse.cz>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8146e3d0-89c3-7f79-f786-084c58282c85@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 31-03-20 09:42:46, Vlastimil Babka wrote:
[...]
> > Should we not do this, we'll have to live with the consequences of
> > supporting the full swoop of sysctls are boot params, whatever
> > consequences those may be.
> 
> Of course when the first user tries to set some particular sysctl as boot param
> and finds and reports it doesn't work as intended, then it can be fixed or
> blacklisted and it can't break anyone else?

Absolutely agreed. I would be really careful to not overengineer this
whole thing.

-- 
Michal Hocko
SUSE Labs
