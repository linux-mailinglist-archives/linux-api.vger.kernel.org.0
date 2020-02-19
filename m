Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6993B16528A
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgBSWcq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 17:32:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43923 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBSWcq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Feb 2020 17:32:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so673739plq.10;
        Wed, 19 Feb 2020 14:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1DsO1OncDrfIH8uK7Ow93e+y96FrmwbGrgT/pjgHroM=;
        b=fmalR7DkpBPObdMLyBmcd9JlCI2mgTpDX90EGmJHKSD3R5eiLHhNx6KlnQpeodoe8j
         rnYgEeiFYVOHRut3iPwkmhxwohdhWJrkn0r1fVx5MeA1PimUeVH3irP/ICpDhmUJyj92
         8lfE8BUujxzwfnUAb5GHA2LlwmoyuXZYXvJwK0eg+ZNC0PW03dNMlDHZxhUOmweFeKye
         xgT8A/7bnBi+1c12fAzSAOL4erQM2hyvQ3F0uqvFORKoBBTeOFhoM53V/dU6tj5YwPb7
         XH8Ujt0zZ2fdph1mQZZanQ21+oNS0iPnHvEwqQ5wYSIUxpCf+Je57HnvnsN6xq0caOhG
         avsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1DsO1OncDrfIH8uK7Ow93e+y96FrmwbGrgT/pjgHroM=;
        b=slHfraLhGIAlU84j9hSKZO7O3Zlssr+Cq+ZU8lC8ISg6eIm6jAdc4r56zyB4GkAgo1
         1P3RWijPAFMz9Ood67eabSQPtAFTzAEAftfGKcadhBlv334nfvei1bGML30PAhOiISqt
         OywcMblxCtGZ88L6rXyHizfiz4J9R6xCKAL2oNDbmKPhpOzzL/W0IhiHaxDL5/ahcNIJ
         90KljiAzcaeoSsBC+QRpgcd09qy6UNcmh1QGYjAOgpXx1qkD1kn8n0tLMFWqWPD5oMyr
         p6PHO7+2sGsk0YOoglviKtE7t9SDco++OUZxwBfD4ahi+JDkT/mBbJ8jxKXOOSvxV5XP
         7Thg==
X-Gm-Message-State: APjAAAV5pmgh6zp5ssDuOkROn4KnKtrTjFFMNtC7XLBEFBsoJye6OHyF
        9afMVLujDdVB5YNr7G6WsLk9W825
X-Google-Smtp-Source: APXvYqxlZYooOZVZFUvzpT9sR0gVV4abtAmJBaIgGs5GpYxSSi0c5wgtvi6j5OYW51sqJcNMpcl8Xw==
X-Received: by 2002:a17:902:d688:: with SMTP id v8mr28891544ply.238.1582151565494;
        Wed, 19 Feb 2020 14:32:45 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id x190sm630390pfb.96.2020.02.19.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:32:43 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:32:41 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 0/7] introduce memory hinting API for external process
Message-ID: <20200219223241.GA148976@google.com>
References: <20200219014433.88424-1-minchan@kernel.org>
 <20200219120123.07dda51c29006a892059ccde@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219120123.07dda51c29006a892059ccde@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrew,

On Wed, Feb 19, 2020 at 12:01:23PM -0800, Andrew Morton wrote:
> On Tue, 18 Feb 2020 17:44:26 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > application could give hints to kernel what memory range are preferred to be
> > reclaimed. However, in some platform(e.g., Android), the information
> > required to make the hinting decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without any app
> > involvement.
> > 
> 
> This patchset doesn't seem to be getting a lot of interest from other
> potential users?  It seems very specialized.  Are there or will there
> ever be any users of this apart from one Android daemon?


Quote from http://lkml.kernel.org/r/20190531064313.193437-1-minchan@kernel.org

"
Brian Geffon in ChromeOS team had an experiment with process_madvise(2)
Quote form him:
"What I found is that by using process_madvise after a tab has been back
grounded for more than 45 seconds reduced the average tab switch times by
25%! This is a huge result and very obvious validation that process_madvise
hints works well for the ChromeOS use case."
"

> 
> Also, it doesn't terribly hard for ActivityManagerService to tell
> another process "now run madvise with these arguments".  Please explain
> why this is not practical in ActivityManagerService and also within
> other potential users of this syscall.

I think that's the almost a same question why ptrace doesn't work so
I summarizes the part in [2/7]:

* makes target task runnable creates memory layout change window so
 hiniting a wrong vma

* target task(e.g., background task) could live in little core with
  cpuset/group limited environment so we couldn't react quick enough,
  which causes more killing.


Thanks.
