Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57A19FB02
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgDFRI0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 13:08:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgDFRIZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 13:08:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id v23so24219pfm.1;
        Mon, 06 Apr 2020 10:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zaXeCIKa/04xAB8MmodjJgT7JeJhzRdAxQcRW/0TGww=;
        b=ep11HTvELnApaXEor0llp2j6bK2197HT6th9uB59sWES/zsm0R/ToZc/e7T1RjVIZE
         EQv/6JLS9duXmFbV1qBVCX7rsl332QvP63vqXOiEx1Gwi7bZyZ8uUuRWFdWyyYg0DZ8Q
         Vm85hrUvzQXsbIeXGWIuK+NQ4t2pe4KWg1OgbNl9BH6vYCsdKzCb9fGk3MurZ0vM/Zl6
         u/6NdjyrM9LrfJEI8BUioEwxL60Q4pEfzzugKl70CLl9W6HPvU36wNVfbLUxST/vGwEd
         /SntJO+jH+3CWj1/+fdJwGTkgJid5l0lAM1gIh5W4v6orxQSRWmZxPzLBMac0QlJn2TV
         E+CA==
X-Gm-Message-State: AGi0PubwF+tQ5B1gd8JruPuRdmClCZlzY0rfr4W8n7KPHqfAzTQzDYEW
        ZLXF2BGo8ex/miRbs5A0gko=
X-Google-Smtp-Source: APiQypJ9XkDYt38q2mJtSLza4PVdlKnHbUCkqeIRzEJCfTivTo/drR4DFb5YNsn2t8LPMWqmhBrWTg==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr408779pfc.303.1586192904248;
        Mon, 06 Apr 2020 10:08:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o192sm8883072pfg.196.2020.04.06.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:08:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5269C40246; Mon,  6 Apr 2020 17:08:22 +0000 (UTC)
Date:   Mon, 6 Apr 2020 17:08:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20200406170822.GE11244@42.do-not-panic.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com>
 <202004021017.3A23B759@keescook>
 <20200402205932.GM11244@42.do-not-panic.com>
 <202004031654.C4389A04EF@keescook>
 <20200406140836.GA11244@42.do-not-panic.com>
 <202004060856.6BC17C5C99@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004060856.6BC17C5C99@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 06, 2020 at 08:58:50AM -0700, Kees Cook wrote:
> On Mon, Apr 06, 2020 at 02:08:36PM +0000, Luis Chamberlain wrote:
> > > Yes. Doing an internal extension isn't testing the actual code.
> > 
> > But it would.
> > 
> > [...]
> > > I don't think anything is needed for this series. It can be boot tested
> > > manually.
> > 
> > Why test it manually when it could be tested automatically with a new kconfig?
> 
> So, my impression is that adding code to the internals to test the
> internals isn't a valid test (or at least makes it fragile) because the
> test would depend on the changes to the internals (or at least depend on
> non-default non-production CONFIGs).

The *internal* aspect here is an extension to boot params under a
kconfig which would simply append to it, as if the user would have
added some more params. Since we already have test sysctl params the
only one we'd need to add on the test driver would be a dummy one which
tests the alias, on the second patch. We should have enough sysctls to
already test dummy values.

Nothing else would be needed as the sysctl test driver would just need
to test that the values expected when this is enabled is set.

> Can you send a patch for what you think this should look like? Perhaps
> I'm not correctly imagining what you're describing?

I rather get the person involved in the changes to do the testing so
as they're the ones designing the feature. If however it is not clear
what I mean I'm happy to elaborate.

Vlastimil do you get what I mean?

> Regardless of testing, I think this series is ready for -mm.

I'm happy for it to go in provided we at least devise a follow up plan
for testing. Otherwise -- like other things, it won't get done.

  Luis
