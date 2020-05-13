Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAB21D144C
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEMNPg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 May 2020 09:15:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37965 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgEMNPg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 May 2020 09:15:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id u5so5157277pgn.5;
        Wed, 13 May 2020 06:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VEBUE/dt95vl+GkpIooPeRD206RTMRg0kBeuKHBdFMY=;
        b=SSHvpXGz8Vb2jhT+RhKOzBYF2UQMNVQzu2KvYEDX/uYNyRQ5txx6gs1OnhzKaLKfm/
         XCiMzCU/OPQn2fXy7uKdMUfg5QUVXsM5rMgvW/6igrs+7s3acziP5BVOleuna2wh9tt4
         hQxwdV1zDXQxrYRQwYzkEnjS6Pj1RhExBouDOyq4l+xgRySfK7wwnzAJT6uFO2z0UFqG
         nfBc1V5oRlQCH8JicQgpC8Q0Bzpu5RnE/TJoSNT7HMRnqOtCmTqSTsV/3liFiBDP/bqV
         nxJqnN0OaKz2Hj64JrbfVTa0JsLxLmDHnoiHXJWQW0pESK8YMuT6Lp5yElasm8Pzy2N9
         J1GQ==
X-Gm-Message-State: AGi0Pubooessgvj8B5zmOc6LfhmUXWicppgit3OcGuRgfuIgrFyJZRPs
        WRpUE3zx2g1ze4gXDTdttSk=
X-Google-Smtp-Source: APiQypJAq8SfvBNksU6hYHSrxfbgqlfrrNYtZxOc+SvIoDj8gVf3OcL5dVz0pBjX95ZNI7nn5szd2A==
X-Received: by 2002:a63:e242:: with SMTP id y2mr23815627pgj.205.1589375734552;
        Wed, 13 May 2020 06:15:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w73sm1970992pfd.113.2020.05.13.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:15:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B2A064063E; Wed, 13 May 2020 13:15:32 +0000 (UTC)
Date:   Wed, 13 May 2020 13:15:32 +0000
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
Subject: Re: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot
 parameter
Message-ID: <20200513131532.GO11244@42.do-not-panic.com>
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-6-vbabka@suse.cz>
 <20200427183913.GH11244@42.do-not-panic.com>
 <028d1996-9f4c-20c6-fb2a-706baa919dde@suse.cz>
 <20200511183155.GT11244@42.do-not-panic.com>
 <d07e1dc9-cc2d-d471-2882-8ec563878fe7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07e1dc9-cc2d-d471-2882-8ec563878fe7@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 13, 2020 at 10:58:16AM +0200, Vlastimil Babka wrote:
> On 5/11/20 8:31 PM, Luis Chamberlain wrote:
> > On Mon, May 11, 2020 at 01:05:22PM +0200, Vlastimil Babka wrote:
> >> ----8<----
> >> From a999e993a89e521b152bbd4b1466f69e62879c30 Mon Sep 17 00:00:00 2001
> >> From: Vlastimil Babka <vbabka@suse.cz>
> >> Date: Mon, 11 May 2020 12:59:49 +0200
> >> Subject: [PATCH] lib/test_sysctl: support testing of sysctl. boot parameter -
> >>  fix
> >> 
> >> Skip the new test if boot_int sysctl is not present, otherwise, per Luis,
> >> "This would fail if someone uses this script to test an older kernel, and
> >> the scripts in selftests are supposed to work with older kernels."
> >> 
> >> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  tools/testing/selftests/sysctl/sysctl.sh | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >> 
> >> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> >> index ef6417b8067b..148704f465b5 100755
> >> --- a/tools/testing/selftests/sysctl/sysctl.sh
> >> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> >> @@ -756,6 +756,11 @@ sysctl_test_0006()
> > 
> > You want to:
> > 
> >                                                                                 
> > # Kselftest framework requirement - SKIP code is 4.                             
> > ksft_skip=4 
> > 
> >>  sysctl_test_0007()
> >>  {
> >>  	TARGET="${SYSCTL}/boot_int"
> >> +	if [ ! -f $TARGET ]; then
> >> +		echo "Skipping test for $TARGET as it is not present ..."
> >> +		return 0
> >> +	fi
> > 
> > And return 4 instead.
> 
> If I return it from the function, nobody will care, AFAICS. If I 'exit
> $ksft_skip', is that correct if it's just a single test out of 7?

yes please do that.

  Luis
