Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B819149918
	for <lists+linux-api@lfdr.de>; Sun, 26 Jan 2020 06:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgAZFmy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 26 Jan 2020 00:42:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46362 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAZFmy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 26 Jan 2020 00:42:54 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so4881567ilm.13
        for <linux-api@vger.kernel.org>; Sat, 25 Jan 2020 21:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0FozRu6Z46A1Ox9dVGHRP4DE9HvTC18OKQ2gVKB5H0I=;
        b=btm3FgLJ76pCbaN9E1aHd2oRO0ynyht6XDpRf1NqBO0KsxDdMPCDLlJSI+R/y7CzNp
         oTob9nBVf1guTbe87lKoYbuKDoC0Ql9g/TGdEcmgcKa22CDAGLFRuC4fp19A9o6yHTL3
         BEFHMz/mK29Nu8bLopbByot+VLxOTUCq1nUjjgFkqgAQFOGrA9JRqBVEU3vbEbGYj1fY
         LhGd7pEFDzL3Fcljj7NX6cElajCJ0vMkdIgbIrk1Y9Hm6TS7KcKXSQp5DVDzoJYpi0Tb
         ww4IeJfARco7kUDRhNK5PuWzvJ0qetZih0El03fZ7BBrQRxw9DU0SwfvRfjIAlAKKCp4
         kREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0FozRu6Z46A1Ox9dVGHRP4DE9HvTC18OKQ2gVKB5H0I=;
        b=SV+ApsOMZZCYuDDwiIAiYPp6hKn6N3i6NNEs9p8ag+z/f4P5YArxIZWzprS5QAFPEn
         9JVrXvi0CNAB0Jeap67ADMwqDqN0JTI4vohT47VE5sb8nbcqexbXq++NP8zbLKCq6JAm
         bjFarYfgLletna4WQAbh2inePrYwBbqsJzz4BUNcnvOPkuQ6GByB1LRexMc10FmAno88
         DEXQIrX6M+QS2C66etptDntSVRlSecFnTFVM5s0Qf0UbWiTWNH4li1rX6M2xPigkzd+Y
         pJy3BMKXcc1x5ovM0ym4Sb5W3Sceilfeim93TbjTwdb7v6XMipvmwS/XR+kpxHGWmjHR
         qoJQ==
X-Gm-Message-State: APjAAAWf4gGe19qAuezhBA+f72RNP+JPSfqqDUUxI1fIcazr8TS3b+qH
        1roX34cbgfxKtBkq9ergaTsJxA==
X-Google-Smtp-Source: APXvYqwEmcq7qaAbzib65zO2VCQ8YB0IQaaR8HionrT430XtGRaSzx5polOejYPQ1Bv9MvnRpMQiDg==
X-Received: by 2002:a92:de46:: with SMTP id e6mr9722912ilr.122.1580017373261;
        Sat, 25 Jan 2020 21:42:53 -0800 (PST)
Received: from cisco ([2601:282:902:b340:51e3:9841:c212:5f6])
        by smtp.gmail.com with ESMTPSA id t15sm3350809ili.50.2020.01.25.21.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 21:42:52 -0800 (PST)
Date:   Sat, 25 Jan 2020 21:42:56 -0800
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200126054256.GB4151@cisco>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
 <20200124180332.GA4151@cisco>
 <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn_WXwxJ6Md4rgFzdAY_xea4TmVDdQc1iJDObEMm5Yc79g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 24, 2020 at 12:09:37PM -0800, Sargun Dhillon wrote:
> On Fri, Jan 24, 2020 at 10:03 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> > > Currently, this just opens the group leader of the thread that triggere
> > > the event, as pidfds (currently) are limited to group leaders.
> >
> > I don't love the semantics of this; when they're not limited to thread
> > group leaders any more, we won't be able to change this. Is that work
> > far off?
> >
> > Tycho
> 
> We would be able to change this in the future if we introduced a flag like
> SECCOMP_USER_NOTIF_FLAG_PIDFD_THREAD which would send a
> pidfd that's for the thread, and not just the group leader. The flag could
> either be XOR with SECCOMP_USER_NOTIF_FLAG_PIDFD, or
> could require both. Alternatively, we can rename
> SECCOMP_USER_NOTIF_FLAG_PIDFD to
> SECCOMP_USER_NOTIF_FLAG_GROUP_LEADER_PIDFD.

Ok, but then isn't this just another temporary API? Seems like it's
worth waiting until the Right Way exists.

Tycho
