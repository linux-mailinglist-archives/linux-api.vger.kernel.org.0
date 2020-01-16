Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56ED13D421
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 07:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgAPGKV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 01:10:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:12986 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgAPGKU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 Jan 2020 01:10:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 22:10:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="213965076"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 22:10:14 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iryM8-000Ivc-6I; Thu, 16 Jan 2020 14:10:12 +0800
Date:   Thu, 16 Jan 2020 14:09:51 +0800
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
Subject: Re: [PATCH v27 01/12] Linux Random Number Generator
Message-ID: <202001161241.meGVaLli%lkp@intel.com>
References: <112781836.sNYxTrJJ31@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112781836.sNYxTrJJ31@positron.chronox.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi "Stephan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on cryptodev/master crypto/master v5.5-rc6 next-20200110]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-approach-with-full-SP800-90B/20200110-084934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 68faa679b8be1a74e6663c21c3a9d25d32f1c079
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-130-g1a803e7a-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/char/lrng/lrng_interfaces.c:455:16: sparse: sparse: incorrect type in return expression (different base types)
>> drivers/char/lrng/lrng_interfaces.c:455:16: sparse:    expected unsigned int
>> drivers/char/lrng/lrng_interfaces.c:455:16: sparse:    got restricted __poll_t [assigned] [usertype] mask
>> drivers/char/lrng/lrng_interfaces.c:586:18: sparse: sparse: incorrect type in initializer (different base types)
>> drivers/char/lrng/lrng_interfaces.c:586:18: sparse:    expected restricted __poll_t ( *poll )( ... )
>> drivers/char/lrng/lrng_interfaces.c:586:18: sparse:    got unsigned int ( * )( ... )
   drivers/char/lrng/lrng_interfaces.c:605:49: sparse: sparse: undefined identifier 'GRND_INSECURE'
   drivers/char/lrng/lrng_interfaces.c:613:15: sparse: sparse: undefined identifier 'GRND_INSECURE'
   drivers/char/lrng/lrng_interfaces.c:613:47: sparse: sparse: undefined identifier 'GRND_INSECURE'
   drivers/char/lrng/lrng_interfaces.c:619:21: sparse: sparse: undefined identifier 'GRND_INSECURE'
--
   drivers/char/lrng/lrng_drng.c:378:6: sparse: sparse: symbol 'lrng_reset' was not declared. Should it be static?
>> drivers/char/lrng/lrng_internal.h:235:39: sparse: sparse: context imbalance in 'lrng_drng_inject' - unexpected unlock
>> drivers/char/lrng/lrng_internal.h:235:39: sparse: sparse: context imbalance in 'lrng_drng_seed' - unexpected unlock
>> drivers/char/lrng/lrng_internal.h:235:39: sparse: sparse: context imbalance in 'lrng_drng_get' - unexpected unlock
>> drivers/char/lrng/lrng_internal.h:235:39: sparse: sparse: context imbalance in 'lrng_drngs_init_cc20' - unexpected unlock
>> drivers/char/lrng/lrng_internal.h:235:39: sparse: sparse: context imbalance in '_lrng_reset' - unexpected unlock

vim +455 drivers/char/lrng/lrng_interfaces.c

   442	
   443	static unsigned int lrng_random_poll(struct file *file, poll_table *wait)
   444	{
   445		__poll_t mask;
   446	
   447		poll_wait(file, &lrng_init_wait, wait);
   448		poll_wait(file, &lrng_write_wait, wait);
   449		mask = 0;
   450		if (lrng_state_operational())
   451			mask |= EPOLLIN | EPOLLRDNORM;
   452		if (lrng_need_entropy() ||
   453		    lrng_state_exseed_allow(lrng_noise_source_user))
   454			mask |= EPOLLOUT | EPOLLWRNORM;
 > 455		return mask;
   456	}
   457	
   458	static ssize_t lrng_drng_write_common(const char __user *buffer, size_t count,
   459					      u32 entropy_bits)
   460	{
   461		ssize_t ret = 0;
   462		u8 buf[64] __aligned(LRNG_KCAPI_ALIGN);
   463		const char __user *p = buffer;
   464		u32 orig_entropy_bits = entropy_bits;
   465	
   466		if (!lrng_get_available())
   467			return -EAGAIN;
   468	
   469		count = min_t(size_t, count, INT_MAX);
   470		while (count > 0) {
   471			size_t bytes = min_t(size_t, count, sizeof(buf));
   472			u32 ent = min_t(u32, bytes<<3, entropy_bits);
   473	
   474			if (copy_from_user(&buf, p, bytes))
   475				return -EFAULT;
   476			/* Inject data into entropy pool */
   477			lrng_pool_lfsr(buf, bytes);
   478			lrng_pool_add_entropy(ent);
   479	
   480			count -= bytes;
   481			p += bytes;
   482			ret += bytes;
   483			entropy_bits -= ent;
   484	
   485			cond_resched();
   486		}
   487	
   488		/* Force reseed of DRNG during next data request. */
   489		if (!orig_entropy_bits)
   490			lrng_drng_force_reseed();
   491	
   492		return ret;
   493	}
   494	
   495	static ssize_t lrng_drng_read(struct file *file, char __user *buf,
   496				      size_t nbytes, loff_t *ppos)
   497	{
   498		if (!lrng_state_min_seeded())
   499			pr_notice_ratelimited("%s - use of insufficiently seeded DRNG "
   500					      "(%zu bytes read)\n", current->comm,
   501					      nbytes);
   502		else if (!lrng_state_operational())
   503			pr_debug_ratelimited("%s - use of not fully seeded DRNG (%zu "
   504					     "bytes read)\n", current->comm, nbytes);
   505	
   506		return lrng_read_common(buf, nbytes);
   507	}
   508	
   509	static ssize_t lrng_drng_write(struct file *file, const char __user *buffer,
   510				       size_t count, loff_t *ppos)
   511	{
   512		return lrng_drng_write_common(buffer, count, 0);
   513	}
   514	
   515	static long lrng_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
   516	{
   517		int size, ent_count_bits;
   518		int __user *p = (int __user *)arg;
   519	
   520		switch (cmd) {
   521		case RNDGETENTCNT:
   522			ent_count_bits = lrng_avail_entropy();
   523			if (put_user(ent_count_bits, p))
   524				return -EFAULT;
   525			return 0;
   526		case RNDADDTOENTCNT:
   527			if (!capable(CAP_SYS_ADMIN))
   528				return -EPERM;
   529			if (get_user(ent_count_bits, p))
   530				return -EFAULT;
   531			ent_count_bits = (int)lrng_avail_entropy() + ent_count_bits;
   532			if (ent_count_bits < 0)
   533				ent_count_bits = 0;
   534			if (ent_count_bits > LRNG_POOL_SIZE_BITS)
   535				ent_count_bits = LRNG_POOL_SIZE_BITS;
   536			lrng_pool_set_entropy(ent_count_bits);
   537			return 0;
   538		case RNDADDENTROPY:
   539			if (!capable(CAP_SYS_ADMIN))
   540				return -EPERM;
   541			if (get_user(ent_count_bits, p++))
   542				return -EFAULT;
   543			if (ent_count_bits < 0)
   544				return -EINVAL;
   545			if (get_user(size, p++))
   546				return -EFAULT;
   547			if (size < 0)
   548				return -EINVAL;
   549			lrng_state_exseed_set(lrng_noise_source_user, false);
   550			/* there cannot be more entropy than data */
   551			ent_count_bits = min(ent_count_bits, size<<3);
   552			return lrng_drng_write_common((const char __user *)p, size,
   553						      ent_count_bits);
   554		case RNDZAPENTCNT:
   555		case RNDCLEARPOOL:
   556			/* Clear the entropy pool counter. */
   557			if (!capable(CAP_SYS_ADMIN))
   558				return -EPERM;
   559			lrng_pool_set_entropy(0);
   560			return 0;
   561		case RNDRESEEDCRNG:
   562			/*
   563			 * We leave the capability check here since it is present
   564			 * in the upstream's RNG implementation. Yet, user space
   565			 * can trigger a reseed as easy as writing into /dev/random
   566			 * or /dev/urandom where no privilege is needed.
   567			 */
   568			if (!capable(CAP_SYS_ADMIN))
   569				return -EPERM;
   570			/* Force a reseed of all DRNGs */
   571			lrng_drng_force_reseed();
   572			return 0;
   573		default:
   574			return -EINVAL;
   575		}
   576	}
   577	
   578	static int lrng_fasync(int fd, struct file *filp, int on)
   579	{
   580		return fasync_helper(fd, filp, on, &fasync);
   581	}
   582	
   583	const struct file_operations random_fops = {
   584		.read  = lrng_drng_read_block,
   585		.write = lrng_drng_write,
 > 586		.poll  = lrng_random_poll,
   587		.unlocked_ioctl = lrng_ioctl,
   588		.compat_ioctl = compat_ptr_ioctl,
   589		.fasync = lrng_fasync,
   590		.llseek = noop_llseek,
   591	};
   592	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
