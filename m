Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D861D147A
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgEMNSL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 May 2020 09:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgEMNSL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 13 May 2020 09:18:11 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698B920890;
        Wed, 13 May 2020 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589375890;
        bh=eFMjZY/v2Asht7I/UpE2htqibqHIccOjg5FwflDPi/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o7LZddYK2z9I/7JCKaE67GyFQtLMmnaHdG9dov4EPopF7tYlY27GcP042SKLLw/A/
         Zm9L+FAllu3DLg+ele733AkiVKYLF1BxhTGnr+G7jcvO2VTiPs9ys1LxFhkEo5DoHK
         nFrdgmx9OHOSu3ZE7jlgf9m+LqRtWaLKl5xt4JcQ=
Received: by mail-vs1-f53.google.com with SMTP id u12so10050215vsq.0;
        Wed, 13 May 2020 06:18:10 -0700 (PDT)
X-Gm-Message-State: AGi0PubMVtaQQn8Vidlzgu/nTkb5pD4hdOHnuEDFV3N0eBxmcJjI/OyC
        H6mqxtjcVM2sOcfGN6303p1CB14fkLSKgMXfXPA=
X-Google-Smtp-Source: APiQypKNqBjYJVuB9t2wrPEHjHlrIEdxGdAfeXJ7D823LnhI8WRMmuVeTONcMe3Uk+FV8NdJcvc8W9bFF/8L520ToDc=
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr19498367vsp.198.1589375889355;
 Wed, 13 May 2020 06:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200427180433.7029-1-vbabka@suse.cz> <20200427180433.7029-6-vbabka@suse.cz>
 <20200427183913.GH11244@42.do-not-panic.com> <028d1996-9f4c-20c6-fb2a-706baa919dde@suse.cz>
 <20200511183155.GT11244@42.do-not-panic.com> <d07e1dc9-cc2d-d471-2882-8ec563878fe7@suse.cz>
 <20200513131532.GO11244@42.do-not-panic.com>
In-Reply-To: <20200513131532.GO11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Wed, 13 May 2020 07:17:57 -0600
X-Gmail-Original-Message-ID: <CAB=NE6WGN=TiXE3PL3sAXa+5q9n8a83-vONMv1c1_HLMqnzPew@mail.gmail.com>
Message-ID: <CAB=NE6WGN=TiXE3PL3sAXa+5q9n8a83-vONMv1c1_HLMqnzPew@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot parameter
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 13, 2020 at 7:15 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 10:58:16AM +0200, Vlastimil Babka wrote:
> > On 5/11/20 8:31 PM, Luis Chamberlain wrote:
> > > On Mon, May 11, 2020 at 01:05:22PM +0200, Vlastimil Babka wrote:
> > >> ----8<----
> > >> From a999e993a89e521b152bbd4b1466f69e62879c30 Mon Sep 17 00:00:00 2001
> > >> From: Vlastimil Babka <vbabka@suse.cz>
> > >> Date: Mon, 11 May 2020 12:59:49 +0200
> > >> Subject: [PATCH] lib/test_sysctl: support testing of sysctl. boot parameter -
> > >>  fix
> > >>
> > >> Skip the new test if boot_int sysctl is not present, otherwise, per Luis,
> > >> "This would fail if someone uses this script to test an older kernel, and
> > >> the scripts in selftests are supposed to work with older kernels."
> > >>
> > >> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > >> ---
> > >>  tools/testing/selftests/sysctl/sysctl.sh | 5 +++++
> > >>  1 file changed, 5 insertions(+)
> > >>
> > >> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> > >> index ef6417b8067b..148704f465b5 100755
> > >> --- a/tools/testing/selftests/sysctl/sysctl.sh
> > >> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> > >> @@ -756,6 +756,11 @@ sysctl_test_0006()
> > >
> > > You want to:
> > >
> > >
> > > # Kselftest framework requirement - SKIP code is 4.
> > > ksft_skip=4
> > >
> > >>  sysctl_test_0007()
> > >>  {
> > >>    TARGET="${SYSCTL}/boot_int"
> > >> +  if [ ! -f $TARGET ]; then
> > >> +          echo "Skipping test for $TARGET as it is not present ..."
> > >> +          return 0
> > >> +  fi
> > >
> > > And return 4 instead.
> >
> > If I return it from the function, nobody will care, AFAICS. If I 'exit
> > $ksft_skip', is that correct if it's just a single test out of 7?
>
> yes please do that.

Ah but once we add test_0008() it may be supported.. so I think return
would be OK
