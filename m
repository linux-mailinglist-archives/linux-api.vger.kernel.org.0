Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC90193985
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 08:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCZHVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 03:21:33 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36125 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZHVd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 03:21:33 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so2051765pjb.1
        for <linux-api@vger.kernel.org>; Thu, 26 Mar 2020 00:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nFKrUEgeFa7EbhKVQYAD2wP/31kNz1QwptTeG1sEwow=;
        b=BAoU/QShY6ywU3pTWp1V9cChIjzV8h5Z2dICalBhYAji0uRIBMWN+0ukKItBUNd6Xs
         wrjaYp9RpQG3zUspc+8FvPKincpU6/Ue05WbJvfgDbkfUqECTXqNLnKKBbSPk0gb6y9C
         FQ2g6g6XgCa+cXCJ6Sp5AxnFS7G5GwjNl+4Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFKrUEgeFa7EbhKVQYAD2wP/31kNz1QwptTeG1sEwow=;
        b=tLmicmRQBjKUKTbAbjVCKHT5080z3n/2mZSvwX2uyOVsIwvLJUh0oIKv6QrX/qWiXN
         DiLBYpWf0rBdi7qcEKEeHyY1VJyxmKa2of39ou9cGG7oUXxtDZzMGzI8a5VIhRGRntdZ
         RmZnJudo76IYS3REAHAjTUW6eXpzcAX7LIXD4CPa38nrj1+EE8qAmRkfsBFx3cxXQZqN
         HZ7xNSyJP/ZiTcWgwsVH8/Hn6BIqe3izl62b6u3khda7Z2HxIJSkpnNdS/NQRgqa9Yg7
         C4HatpFuYuWuG+Ovfx7ncBa7LO8XVoW+7v2nLshkICqJmHWbWm6e0PkCGR9QEy5uQ+3A
         VAQg==
X-Gm-Message-State: ANhLgQ0SXp/ui7kN9OgozqKqbaUIDLBT+CZMFVmHias4vleYCYCbp5Ru
        Mh8hrebfn50N+oVl6zbS4MrePA==
X-Google-Smtp-Source: ADFU+vsRXQ2gRszQo8R/li9R/yQ8ZllZsAs3VyIOYY8ZCPe+z6YoAiBt8mcHHzlQCiWmcataarR3/w==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr7014861pls.7.1585207292475;
        Thu, 26 Mar 2020 00:21:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r4sm922290pgp.53.2020.03.26.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 00:21:31 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:21:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003260018.81648AA67@keescook>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
 <20200326065829.GC27965@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326065829.GC27965@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 26, 2020 at 07:58:29AM +0100, Michal Hocko wrote:
> On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
> > Vlastimil Babka <vbabka@suse.cz> writes:
> [...]
> > > +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> > > +		return 0;
> > 
> > Is there any way we can use a slash separated path.  I know
> > in practice there are not any sysctl names that don't have
> > a '.' in them but why should we artifically limit ourselves?
> 
> Because this is the normal userspace interface? Why should it be any
> different from calling sysctl?

Right. The common method from userspace is dot-separated (which I agree
is weird, but it's been like this for ages: see manpages sysctl(8) and
sysctl.conf(5) for the details and examples). While "/" is accepted by
sysctl, the files shipped in /etc/sysctl.d/ are all using "."  separators.

-- 
Kees Cook
