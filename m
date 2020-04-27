Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6D1BACF2
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD0Sje (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:39:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40311 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgD0Sje (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 14:39:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id n16so9061515pgb.7;
        Mon, 27 Apr 2020 11:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5/BJgBb9+BnsnGu4qvm1p5Drnqy7riS6RgVNSCSYu8=;
        b=ecACkwbBu7S6yt2GI6z3Z95ioyBt1HGF/EwEVQqYKhUNjMo3tM2QenL0Wv7nlMlu6a
         A6Cj1k8c5t42mbXCrKs47OyYQLk21U7fkeBnuoHUla9KkM3nVtApMtVSIyYtpHSVPWqK
         Z7QlR2NQjCI+WeX3yFUKdDZDjFuZIqQ4RaUWe971/wde0O/r2N9ZRMOFq/H97L7qXnVc
         IiLhdrsBXR9vYl0ycLymWZmDivbEGi2uZufeuxxKOIIZx4w1bkzJku/p6m8xrRQnH2+A
         uvWCVSB8NUAqNctgM/lY0MUAKLTmejzCfvy5GwnY4fAebM7eNsTfpQeXjyv5+iZ0527S
         qyvA==
X-Gm-Message-State: AGi0Pua3DaU35oTub+DFWBzVQCoi/YAHuSNQBOxCFxxJj+EI8JuCAzDb
        f+OUDGmbiSRfmuoioVgE9B8=
X-Google-Smtp-Source: APiQypIu2WcZsYqOoI4gNIEcf3o9s3itN8+KJR+9FBk6FHmBMIhT4HV/y3uHuuCMQtd8Jobsnw2Dsg==
X-Received: by 2002:a63:1414:: with SMTP id u20mr6946591pgl.47.1588012773236;
        Mon, 27 Apr 2020 11:39:33 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m3sm14400pjs.17.2020.04.27.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 11:39:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 27F5E403AB; Mon, 27 Apr 2020 18:39:31 +0000 (UTC)
Date:   Mon, 27 Apr 2020 18:39:31 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 4/5] tools/testing/selftests/sysctl/sysctl.sh: support
 CONFIG_TEST_SYSCTL=y
Message-ID: <20200427183931.GI11244@42.do-not-panic.com>
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427180433.7029-5-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 08:04:32PM +0200, Vlastimil Babka wrote:
> The testing script recommends CONFIG_TEST_SYSCTL=y, but actually only works
> with CONFIG_TEST_SYSCTL=m. Testing of sysctl setting via boot param however
> requires the test to be built-in, so make sure the test script supports it.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
