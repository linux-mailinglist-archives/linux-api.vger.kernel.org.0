Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE45148D62
	for <lists+linux-api@lfdr.de>; Fri, 24 Jan 2020 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391145AbgAXSDd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jan 2020 13:03:33 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38986 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbgAXSDd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jan 2020 13:03:33 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so163323pjt.4
        for <linux-api@vger.kernel.org>; Fri, 24 Jan 2020 10:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KYYV9rcdEb+nT+n76T9IL2Mvjnz++gVjwO67Ed6lDIA=;
        b=QLBgRrCRV3Qrx7BRCpYBc1z6C+go7OJtBBMTk2vteQruNfk+Jb4+PlqJWk6jwdNFO9
         Vw2yUcc/MCqfZTQ7O6Iqm/RGOxZOBFCNJ6kCB7uJEIIlLDpt/qm2YX1+QHI0GYc6jiTu
         +qzBhavepYUedI7ys2+YwQW/Bl+IVfsxJR0cnDnVJ9ED/qsqfOra6kyi8LhDIYt4kxy7
         5Xj2aDsQ4WI17egTXDEFzF/O4IuypL8PFT07s029KMwqFmjLcdgGszHc7iny2Ynu33ot
         cLpN+/Ki10iyRJlbelw5tEM189ZIgkpyZlt5eCKwGw+flz72N+3qAgZ0fIZpiTfHgC+G
         DToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KYYV9rcdEb+nT+n76T9IL2Mvjnz++gVjwO67Ed6lDIA=;
        b=MPOFKhCYXhCSUQxyYLQ4i44nfpbuI/CMdvY33L8NuaBSJ/RHeF2nZc6U5+03vEU/5p
         mfR7+czbEDDsvBoYmkBpa+xFs0O+DxcoC4wAu2ob9U4miGCl2FwREjbeJaONiTCbFqUl
         NfjFG200M9KArky4+cYlX8k4t6GUjSM7CVLcfSrS1mi/R3ROP+5+MBy/R2nf6cXSFpuz
         1ZNw5Q3eIBmhqn1ts+z8OQ9Oxn8d9AevgEMVZo/GPwHYo8PP/jlk5UEXAsQO4Wh3k4m8
         azLAv7hyvY4stt8O7cQ/BK3CG/h1ZEOcaoFGBtIPcc333gWQCXpMOGgsvLkhnfBbT0ue
         19qw==
X-Gm-Message-State: APjAAAXquAHUrqmMy+wwRu91Cv3Xpo6fjHKgRLkgjlUH+TtNwW+lYB2N
        pN3/GBoAJC3r15uHyfpdIkVIaA==
X-Google-Smtp-Source: APXvYqxzwjaX46e/1fUSjuFqRje3gg6dT16MaHtJeX4pLiTiDcr2YsyJMPFPS/RCb7fTnNGkezX5Jw==
X-Received: by 2002:a17:90a:2763:: with SMTP id o90mr459921pje.110.1579889012413;
        Fri, 24 Jan 2020 10:03:32 -0800 (PST)
Received: from cisco ([69.162.16.18])
        by smtp.gmail.com with ESMTPSA id v15sm7022881pju.15.2020.01.24.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:03:31 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:03:32 -0800
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, christian.brauner@ubuntu.com
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200124180332.GA4151@cisco>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124091743.3357-4-sargun@sargun.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> Currently, this just opens the group leader of the thread that triggere
> the event, as pidfds (currently) are limited to group leaders.

I don't love the semantics of this; when they're not limited to thread
group leaders any more, we won't be able to change this. Is that work
far off?

Tycho
