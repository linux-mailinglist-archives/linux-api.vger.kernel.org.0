Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3C137BED
	for <lists+linux-api@lfdr.de>; Sat, 11 Jan 2020 08:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgAKHKE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Jan 2020 02:10:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:63524 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgAKHKE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 11 Jan 2020 02:10:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 23:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,420,1571727600"; 
   d="scan'208";a="234105863"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2020 23:09:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iqAuE-0009Dn-T5; Sat, 11 Jan 2020 15:09:58 +0800
Date:   Sat, 11 Jan 2020 15:09:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v27 04/12] LRNG - add switchable DRNG support
Message-ID: <202001111540.5y2emdGQ%lkp@intel.com>
References: <5087131.2PHHu6SUIE@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5087131.2PHHu6SUIE@positron.chronox.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi "Stephan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on cryptodev/master crypto/master v5.5-rc5 next-20200110]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-approach-with-full-SP800-90B/20200110-084934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 68faa679b8be1a74e6663c21c3a9d25d32f1c079
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/char/lrng/lrng_internal.h:239:39: sparse: sparse: context imbalance in 'lrng_drng_switch' - unexpected unlock

vim +/lrng_drng_switch +239 drivers/char/lrng/lrng_internal.h

58c283819a1e87 Stephan Müller 2020-01-09  233  
58c283819a1e87 Stephan Müller 2020-01-09  234  /* Unlock the DRNG */
58c283819a1e87 Stephan Müller 2020-01-09  235  static __always_inline void lrng_drng_unlock(struct lrng_drng *drng,
58c283819a1e87 Stephan Müller 2020-01-09  236  					     unsigned long *flags)
58c283819a1e87 Stephan Müller 2020-01-09  237  {
58c283819a1e87 Stephan Müller 2020-01-09  238  	if (lrng_drng_is_atomic(drng))
58c283819a1e87 Stephan Müller 2020-01-09 @239  		spin_unlock_irqrestore(&drng->spin_lock, *flags);
58c283819a1e87 Stephan Müller 2020-01-09  240  	else
58c283819a1e87 Stephan Müller 2020-01-09  241  		mutex_unlock(&drng->lock);
58c283819a1e87 Stephan Müller 2020-01-09  242  }
58c283819a1e87 Stephan Müller 2020-01-09  243  

:::::: The code at line 239 was first introduced by commit
:::::: 58c283819a1e879bc2e30d05720285f9709f7f6d Linux Random Number Generator

:::::: TO: Stephan Müller <smueller@chronox.de>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
