Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7713024C98
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfEUK0V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 06:26:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38488 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUK0U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 06:26:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id b76so8850195pfb.5;
        Tue, 21 May 2019 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7oTWqJm+U+8EwWIlN8PXARmqW1yabluA4GVB5Q/Ymc=;
        b=d/JcV1xuIxQEiJwk7yG4v/8OtBPTzjRoH8pRp+ELNSATolCfDK10qD/aK35UikxFIH
         XeQP6Deb0NOJGW9tREokTHWw5iFX8kZxVfgFeb/CCvMv2F9O3egSSZNvvB7f2WZlGxbI
         u80t7LgdQY+wj3uWSQsxNk9jKK9aZiyNeusSuazL9BtuzJEfWCE2KkS4J0qf++Sxcpyy
         m1IVjgGh1hp9/6t4cp2N7Lpabf829ZtUVbTkGefGfgmPgYsZ8w6H0HNRrKvWjWordBwS
         lwFekyCyWpBkKcRcnAHRnL9rPS9xJITzC59oT29L99JwuLJ/c2TsdbdElO5uRbjpqpiI
         R+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7oTWqJm+U+8EwWIlN8PXARmqW1yabluA4GVB5Q/Ymc=;
        b=hdXbS5JMwn9tfTdNTlZfgRYE4C/oDPQAAi/mJsFnsqnE+iaR3T7cNgnIPphiHFhXhk
         3D3r+T+I/+3MkHh4dwSCpjWhpj9Uluh6ML4isjS4xhjcOjHydv4nBhcJwZPV7AOHXUDb
         qPPdq1NXCuwLQCCJ8967g5s/aLXuB6R3N/CKbfpMlAuN1ohucbsy73T7GqOimbGORc9s
         REL7kMe4LZAGNsFRmuN29N23NVu5JL6pcjbxe2QWfVpt/LbS+hUT5a+QoX/e9tEU8Sr3
         jGVvzskBueXS5RU5fneT2Xzy5zVyE9zgtHWhMXPARhabD+G+x6y+7qTK+MnFoTBJlV8f
         akZg==
X-Gm-Message-State: APjAAAXr4+CYTnrsij9HgqVwkftwPM4DQrV2mbYjEomzJdFa16xcyeV1
        8SAxw4LrnCVW9TpmuZvtqa0=
X-Google-Smtp-Source: APXvYqzZdjlSTwRjqi+DHWVHAtfu7VOytFN2Av0aQnixHQc7zc41tJwI2PuEyhis7/e/9mFRwgfs2w==
X-Received: by 2002:a63:754b:: with SMTP id f11mr81175818pgn.32.1558434379902;
        Tue, 21 May 2019 03:26:19 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z7sm26834601pfr.23.2019.05.21.03.26.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 03:26:18 -0700 (PDT)
Date:   Tue, 21 May 2019 19:26:13 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190521102613.GC219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-7-minchan@kernel.org>
 <20190520092258.GZ6836@dhcp22.suse.cz>
 <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521062421.GD32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 08:24:21AM +0200, Michal Hocko wrote:
> On Tue 21-05-19 11:48:20, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 11:22:58AM +0200, Michal Hocko wrote:
> > > [Cc linux-api]
> > > 
> > > On Mon 20-05-19 12:52:53, Minchan Kim wrote:
> > > > Currently, process_madvise syscall works for only one address range
> > > > so user should call the syscall several times to give hints to
> > > > multiple address range.
> > > 
> > > Is that a problem? How big of a problem? Any numbers?
> > 
> > We easily have 2000+ vma so it's not trivial overhead. I will come up
> > with number in the description at respin.
> 
> Does this really have to be a fast operation? I would expect the monitor
> is by no means a fast path. The system call overhead is not what it used
> to be, sigh, but still for something that is not a hot path it should be
> tolerable, especially when the whole operation is quite expensive on its
> own (wrt. the syscall entry/exit).

What's different with process_vm_[readv|writev] and vmsplice?
If the range needed to be covered is a lot, vector operation makes senese
to me.

> 
> I am not saying we do not need a multiplexing API, I am just not sure
> we need it right away. Btw. there was some demand for other MM syscalls
> to provide a multiplexing API (e.g. mprotect), maybe it would be better
> to handle those in one go?

That's the exactly what Daniel Colascione suggested from internal
review. That would be a interesting approach if we could aggregate
all of system call in one go.

> -- 
> Michal Hocko
> SUSE Labs
