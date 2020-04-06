Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5841D19F97E
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgDFP6x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 11:58:53 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52045 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgDFP6x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 11:58:53 -0400
Received: by mail-pj1-f65.google.com with SMTP id fr8so29819pjb.1
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WhhzEvhj7V6SaqGfbxM9gAfOTnFcEdBBvYMHzIDChN4=;
        b=LmMhIiHBv8JKUwBK1L17Slsqu3pI1ZCj3WAAiYxR/QFR1qVVAz4IYPwxfWMPMZ7zXm
         9Wax7svqkeAr2xHTEIyNbAJ/iUo4weccl0+nxbm3QSdyRtI1nG9no3Rpx1h0oKuXEq2s
         oLCH+OVR+6Db2zO7UsCV6KbjY1WiOXXI8xjXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WhhzEvhj7V6SaqGfbxM9gAfOTnFcEdBBvYMHzIDChN4=;
        b=TCGahcCBp+Zl2uNWHZTPdhhH//6l//R1o/Gus6t/KmZv+HuHHmWy34mhAcoFTGFTHh
         sLHTXhvK1WYrv/9FeHJuY5/SUCWSg+rq1l7iG7MoGr6yjgCjPLFAL8hfltS730QqWtut
         2GQ9hy1i+Ttgempo5mR4Rjk/5ptuTqs3OVAlCUvXkRsJDwlNZSB4A3p4YGg7NBUtX0X6
         8IX3AUq6ZX0911FTmtn9hUIMshvtHMkP4znRNuTOuCMJcfYmcel9AeC46WBDeHd8bxHq
         e16qfgm5MTVCq4NmFuVXd0CZYXYLfB/rmv5vXwTYcdmerTVdEJztJsk9lKBCNEl+QIRX
         gEhQ==
X-Gm-Message-State: AGi0PubE0imJ4h5SiKYrQSm4XYB5Rxw3J6qxe8K2XuyamtZf5COGM27A
        kOZ51gSxOgSAAAVpu72+WBlxAQ==
X-Google-Smtp-Source: APiQypJ454SwMkM4BAp+LRIUIyKBkrYFbcaUu2UEQwNI+5DjasWsw/sS58aewnFEQncDuWljFvZJ8Q==
X-Received: by 2002:a17:902:7203:: with SMTP id ba3mr20816991plb.37.1586188732549;
        Mon, 06 Apr 2020 08:58:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r64sm24942pjb.15.2020.04.06.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:58:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:58:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <202004060856.6BC17C5C99@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com>
 <202004021017.3A23B759@keescook>
 <20200402205932.GM11244@42.do-not-panic.com>
 <202004031654.C4389A04EF@keescook>
 <20200406140836.GA11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406140836.GA11244@42.do-not-panic.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 06, 2020 at 02:08:36PM +0000, Luis Chamberlain wrote:
> > Yes. Doing an internal extension isn't testing the actual code.
> 
> But it would.
> 
> [...]
> > I don't think anything is needed for this series. It can be boot tested
> > manually.
> 
> Why test it manually when it could be tested automatically with a new kconfig?

So, my impression is that adding code to the internals to test the
internals isn't a valid test (or at least makes it fragile) because the
test would depend on the changes to the internals (or at least depend on
non-default non-production CONFIGs).

Can you send a patch for what you think this should look like? Perhaps
I'm not correctly imagining what you're describing?

Regardless of testing, I think this series is ready for -mm.

-- 
Kees Cook
