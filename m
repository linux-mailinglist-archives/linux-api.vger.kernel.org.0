Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A331A99C
	for <lists+linux-api@lfdr.de>; Sat, 13 Feb 2021 03:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBMCGn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Feb 2021 21:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBMCGn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Feb 2021 21:06:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8DC061574;
        Fri, 12 Feb 2021 18:06:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cv23so600967pjb.5;
        Fri, 12 Feb 2021 18:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGYYHfHz7dZ/7g0jBdDZ3AGipqlsk5TZczIuK7u7VlQ=;
        b=Y3QzPu/8ZTMyNp/Iu/C1ZfNuQ93GcwjnmB7NnzVX3rY44JQ683VaHhMa7phWVl1wT+
         mhj5kyE68A2GSMWBe9Qzxm5W19TF7LUVq2Bz5/U1XEuvlHtekT2Q2qsvbGV/MO2EW1ju
         l+uucrhoX25S6ayMflupvyKUJv8qYGDQFjqvLO42LUCbkAE5OjMrTaYQk35Af/Wx/VLz
         6p0aLlq3QR+x6uSlUxol+FvW8kH/L1UNRNFor7NKYTaxiNN/hwIfZEVUtTtp1cG+2p46
         ilsqcNKirF2wwuy8xoR/y0Swao/gpJMjUI5u4cUC+8C9IW/1jrqn/EXAa6xfkfTMy5Yg
         nGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGYYHfHz7dZ/7g0jBdDZ3AGipqlsk5TZczIuK7u7VlQ=;
        b=A4DM83DJhLVDEC68RQPat+hFmthhYS/JTihD8OyfXg9ugL9nCXOphtBY/jZRHOtoHm
         Q7CGQixc+QSSpQ45RHRU1/SEqTk3QEVw+KNpRg3Ao8jODRh3huKlECdX0ExcNpsQPbuc
         paSQ8vP2j3vAelYeVsdhjtxLJkdZzxUdLOP+6Fj6kNRCMJiCGeWilelSwiWpJtMVtEXg
         YHWtrZMy83QX611cY+WMHqWyeBNagZdbaHXVHhoIwy5lmYbwEFwmI52MfJRa8ZQjzUaS
         zvzBa+EnCucqQFDa7F5jZ2SXknX/HcHqToHd8jsHjhJwi+z5tmfWGaJJIJnIFoU34QE/
         19/g==
X-Gm-Message-State: AOAM532IQZIYz1N2f7pJ44210SC91l9vFe3uuKllGoUeDxPhtRlk57kj
        EuW/cixkQUEaHuoDpaNE3i8=
X-Google-Smtp-Source: ABdhPJzkJpR0uD9V1icJjdAsQMyp5TB2l3rkkSOlLNMwBuYBAPqx3yycd0WYtM9d1xaO/WYzfZn8nQ==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr5241947pjr.134.1613181962451;
        Fri, 12 Feb 2021 18:06:02 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 8sm2877971pjl.55.2021.02.12.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 18:06:01 -0800 (PST)
Date:   Sat, 13 Feb 2021 11:06:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-cifsd-devel@lists.sourceforge.net,
        Samba Technical <samba-technical@lists.samba.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: [Linux-cifsd-devel] RFC: ksmbd ABI for ksmbd-tools...
Message-ID: <YCc0CAR46wkOLYH8@jagdpanzerIV.localdomain>
References: <adf41e69-5915-06aa-6f8b-8ffc073fc8a7@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf41e69-5915-06aa-6f8b-8ffc073fc8a7@samba.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On (21/02/12 15:38), Stefan Metzmacher via Linux-cifsd-devel wrote:
> I haven't found the exact place, but ksmbd.mountd starts the kernel-part.
> 
> ksmbd.mountd also acts as some kind of upcall, for the server part,
> that takes care of authentication and some basic DCERPC calls.
> 
> I'm wondering why there are two separate ways to kill the running server,
> 'killall ksmbd.mountd' for the userspace part and
> 'ksmbd.control -s' (which is just a wrapper for
> 'echo -n "hard" > /sys/class/ksmbd-control/kill_server') to shutdown the server part.
> 
> As it's not useful to run any of these two components on its own,
> so I'm wondering why there's no stronger relationship.
> 
> As naive admin I'd assume that the kernel part would detect the exit of ksmbd.mountd
> and shutdown itself.

User-space daemon is just some sort of a database engine, kernel module
queries it when it needs something; otherwise kernel module works without
user-space part just fine and doesn't need it. The goal is that when
user-space crashes or gets restarted after update (critical fix) the server
doesn't panic and doesn't kill itself.

E.g. - when you restart mysql you don't expect httpd to kill itself and
to terminate all existing TCP connections.

[..]
> Can we require that the userspace tool matches the kernel version for a while?

I think such a check exists (or at least it used to). Note that the only
time when version mismatch matters is when sizeof() or layout of the
structures that are used for RPC get updated, or new request commands or
status codes added. IOW, RPC version mismatch is the critical thing.
Otherwise there is no real reason (case by case) to forbid version
mismatch. If user-space gets a memory leak or a NULL pointer dereference
fix then there is no real reasons to force server restart or to force
server module version update, because the fix is completely internal to
the user-space daemon.

	-ss
