Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4FECA26
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2019 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfKAVIK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 Nov 2019 17:08:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39242 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAVIJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 Nov 2019 17:08:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iQe9P-0008Lu-OH
        for linux-api@vger.kernel.org; Fri, 01 Nov 2019 21:08:07 +0000
Received: by mail-il1-f197.google.com with SMTP id x17so9571191ill.7
        for <linux-api@vger.kernel.org>; Fri, 01 Nov 2019 14:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=99Grxk3NP/rj106dyBNQOJBBT+7NzmkfjxIr2ycA+xY=;
        b=K2+rO4+wM14TEWa2DJAEZHSLHhq0hE/y4HK557yWdRbbw1eynBszJyUEt2t3lMkiia
         OLKkEAgpE87TqD8Eh/zfLjFPT8UBqIzTfUb6JFsOppy6SWKvSqm6twrOFA8QE57VOwPU
         jtorUlTV7cQglQr9Wa4NasECvfI0uryz8EvTKguuxPlY205s7AH8pEdD6TT20XzGLgDC
         u5JFyOgz5oiQjUj6HMh7CHT0LHAbnPnMVpym10XvPBk9cr7MCA3+W/jl94Z/LfOfUoKN
         eZyPDNV0m3kwRn8HEOfNL0DqGV7hD0F4yWpqj/I3q6rhNOc2gt2jIWEWxDL2j0YH40hb
         AOMw==
X-Gm-Message-State: APjAAAVvu0d27vmysxR0zFyq2FNR/gB9BLXJixfEVcZfQUi3XlMkqblq
        mh8rqbu1JLPEd74tP4S7AiKYeWvvUhjsXRypmD6doT2SvIVK8RZ9MZ38sydUcgDt3EEYaTIqE22
        MDfxVps98UVCySo7h3B+k84/XC+PH+sGb5gsZlQ==
X-Received: by 2002:a92:3dd8:: with SMTP id k85mr1030086ilf.176.1572642485709;
        Fri, 01 Nov 2019 14:08:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxViiJ/H/ziNdfZ++M2P5LolU+tfBrHJuWfbH2VzvXMEWOTUG2WwEc09JNUg8f928m6IUIo4w==
X-Received: by 2002:a92:3dd8:: with SMTP id k85mr1030038ilf.176.1572642485253;
        Fri, 01 Nov 2019 14:08:05 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id t16sm812926iol.12.2019.11.01.14.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:08:04 -0700 (PDT)
Date:   Fri, 1 Nov 2019 15:08:03 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: tracefs splats in lockdown=confidentiality mode
Message-ID: <20191101210803.GA9841@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

hey,
  fyi, I'm seeing a bunch of errors from tracefs when booting 5.4-rc5 in
lockdown=confidentiality mode:

[    1.763630] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    1.772332] Could not create tracefs 'available_events' entry
[    1.778633] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    1.787095] Could not create tracefs 'set_event' entry
[    1.792412] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
(...)
[    2.899481] Could not create tracefs 'set_graph_notrace' entry
[    2.905671] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    2.913934] ------------[ cut here ]------------
[    2.918435] Could not register function stat for cpu 0
[    2.923717] WARNING: CPU: 1 PID: 1 at kernel/trace/ftrace.c:987 ftrace_init_tracefs_toplevel+0x168/0x1bc
[    2.933939] Modules linked in:
[    2.937290] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.0-050400rc5-generic #201910271430
[    2.946528] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[    2.954088] pstate: 60400005 (nZCv daif +PAN -UAO)
[    2.959359] pc : ftrace_init_tracefs_toplevel+0x168/0x1bc
[    2.965262] lr : ftrace_init_tracefs_toplevel+0x168/0x1bc
[    2.971192] sp : ffff80001002bd40
[    2.974852] x29: ffff80001002bd40 x28: 0000000000000000 
[    2.980680] x27: 0000000000000000 x26: ffff8000119f9358 
[    2.986552] x25: ffff8000119f9580 x24: ffff00007fb77200 
[    2.992359] x23: ffff00007c873e80 x22: ffff80001153d200 
[    2.998201] x21: ffff800010d8ad08 x20: 0000000000000000 
[    3.004007] x19: 0000000000000000 x18: 0000000000000010 
[    3.009851] x17: 0000000000000007 x16: 000000000000000e 
[    3.015674] x15: ffff00007d1213e8 x14: ffffffffffffffff 
[    3.021526] x13: ffff80009002ba47 x12: ffff80001002ba4f 
[    3.027338] x11: ffff800011a1e000 x10: 0000000000000000 
[    3.033148] x9 : ffff800011c13000 x8 : 000000000000015d 
[    3.038984] x7 : 0000000000000017 x6 : ffff800011c129c9 
[    3.044783] x5 : 0000000000000007 x4 : 0000000000000000 
[    3.050617] x3 : 0000000000000000 x2 : 00000000ffffffff 
[    3.056430] x1 : bcf0a68bd924d700 x0 : 0000000000000000 
[    3.062258] Call trace:
[    3.064951]  ftrace_init_tracefs_toplevel+0x168/0x1bc
[    3.070571]  tracer_init_tracefs+0xc0/0x1fc
[    3.075165]  do_one_initcall+0x50/0x220
[    3.079384]  kernel_init_freeable+0x1ec/0x2b0
[    3.084186]  kernel_init+0x18/0x108
[    3.088032]  ret_from_fork+0x10/0x18
[    3.091983] ---[ end trace 32f7e54339335d2a ]---
[    3.097149] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.105311] Could not create tracefs 'tracing_thresh' entry
[    3.110762] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.119199] Could not create tracefs 'README' entry
[    3.124212] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.132920] Could not create tracefs 'saved_cmdlines' entry
[    3.139075] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.147592] Could not create tracefs 'saved_cmdlines_size' entry
[    3.153950] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.162288] Could not create tracefs 'saved_tgids' entry
[    3.206061] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.214629] Could not create tracefs 'dyn_ftrace_total_info' entry
[    3.221063] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.229245] Could not create tracefs 'funcgraph-overrun' entry
[    3.234990] ------------[ cut here ]------------
[    3.239724] Failed to create trace option: funcgraph-overrun
[    3.239774] WARNING: CPU: 1 PID: 1 at kernel/trace/trace.c:8106 create_trace_option_files+0x200/0x230
[    3.255931] Modules linked in:
[    3.259332] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.4.0-050400rc5-generic #201910271430
[    3.270051] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[    3.277621] pstate: 60400005 (nZCv daif +PAN -UAO)
[    3.282902] pc : create_trace_option_files+0x200/0x230
[    3.288564] lr : create_trace_option_files+0x200/0x230
[    3.294247] sp : ffff80001002bd10
[    3.297914] x29: ffff80001002bd10 x28: ffff800011a34508 
[    3.303769] x27: ffff00007cb12e00 x26: ffff800011bb243d 
[    3.309638] x25: ffff800010d8b750 x24: ffff00007cb12e00 
[    3.315485] x23: 0000000000000000 x22: ffff800011a34508 
[    3.321327] x21: ffff800011a344d0 x20: 0000000000000000 
[    3.327284] x19: ffff800011a320b8 x18: 0000000000000010 
[    3.333121] x17: 0000000000000007 x16: 000000000000000e 
[    3.338980] x15: ffff00007d1213e8 x14: ffffffffffffffff 
[    3.344827] x13: ffff80009002b9a7 x12: ffff80001002b9af 
[    3.350690] x11: ffff800011a1e000 x10: 0000000000000000 
[    3.356524] x9 : 00000000fffffffe x8 : 6870617267636e75 
[    3.362394] x7 : 66203a6e6f697470 x6 : ffff800011c12498 
[    3.368229] x5 : 0000000000000030 x4 : 0000000000000000 
[    3.374082] x3 : 0000000000000000 x2 : 00000000ffffffff 
[    3.379915] x1 : bcf0a68bd924d700 x0 : 0000000000000000 
[    3.385768] Call trace:
[    3.388478]  create_trace_option_files+0x200/0x230
[    3.393849]  __update_tracer_options+0x34/0x48
[    3.398748]  tracer_init_tracefs+0x1e0/0x1fc
[    3.403454]  do_one_initcall+0x50/0x220
[    3.407692]  kernel_init_freeable+0x1ec/0x2b0
[    3.412494]  kernel_init+0x18/0x108
[    3.416351]  ret_from_fork+0x10/0x18
[    3.420287] ---[ end trace 32f7e54339335d2b ]---
[    3.425479] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.433724] Could not create tracefs 'funcgraph-cpu' entry
(...)
[    3.692698] Could not create tracefs 'uprobe_events' entry
[    3.698724] Lockdown: swapper/0: use of tracefs is restricted; see man kernel_lockdown.7
[    3.707217] Could not create tracefs 'uprobe_profile' entry


 -dann
